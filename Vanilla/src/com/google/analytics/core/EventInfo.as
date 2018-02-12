// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.EventInfo

package com.google.analytics.core
{
    import com.google.analytics.data.X10;
    import com.google.analytics.utils.Variables;

    public class EventInfo 
    {

        private var _ext10:X10;
        private var _isEventHit:Boolean;
        private var _x10:X10;

        public function EventInfo(_arg_1:Boolean, _arg_2:X10, _arg_3:X10=null)
        {
            _isEventHit = _arg_1;
            _x10 = _arg_2;
            _ext10 = _arg_3;
        }

        public function toURLString():String
        {
            var _local_1:Variables = toVariables();
            return (_local_1.toString());
        }

        public function get utmt():String
        {
            return ("event");
        }

        public function get utme():String
        {
            return (_x10.renderMergedUrlString(_ext10));
        }

        public function toVariables():Variables
        {
            var _local_1:Variables = new Variables();
            _local_1.URIencode = true;
            if (_isEventHit)
            {
                _local_1.utmt = utmt;
            };
            _local_1.utme = utme;
            return (_local_1);
        }


    }
}//package com.google.analytics.core

