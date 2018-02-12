// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.AlertAction

package com.google.analytics.debug
{
    public class AlertAction 
    {

        public var container:Alert;
        private var _callback:*;
        public var activator:String;
        public var name:String;

        public function AlertAction(_arg_1:String, _arg_2:String, _arg_3:*)
        {
            this.name = _arg_1;
            this.activator = _arg_2;
            _callback = _arg_3;
        }

        public function execute():void
        {
            if (_callback)
            {
                if ((_callback is Function))
                {
                    ((_callback as Function)());
                }
                else
                {
                    if ((_callback is String))
                    {
                        var _local_1:* = container;
                        (_local_1[_callback]());
                    };
                };
            };
        }


    }
}//package com.google.analytics.debug

