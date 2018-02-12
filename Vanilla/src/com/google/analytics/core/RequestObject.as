// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.RequestObject

package com.google.analytics.core
{
    import flash.net.URLRequest;
    import flash.utils.getTimer;

    public class RequestObject 
    {

        public var start:int;
        public var end:int;
        public var request:URLRequest;

        public function RequestObject(_arg_1:URLRequest)
        {
            start = getTimer();
            this.request = _arg_1;
        }

        public function hasCompleted():Boolean
        {
            return (end > 0);
        }

        public function toString():String
        {
            var _local_1:Array = [];
            _local_1.push((("duration: " + duration) + "ms"));
            _local_1.push(("url: " + request.url));
            return (("{ " + _local_1.join(", ")) + " }");
        }

        public function complete():void
        {
            end = getTimer();
        }

        public function get duration():int
        {
            if (!hasCompleted())
            {
                return (0);
            };
            return (end - start);
        }


    }
}//package com.google.analytics.core

