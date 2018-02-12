// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.OrganicReferrer

package com.google.analytics.core
{
    public class OrganicReferrer 
    {

        private var _engine:String;
        private var _keyword:String;

        public function OrganicReferrer(_arg_1:String, _arg_2:String)
        {
            this.engine = _arg_1;
            this.keyword = _arg_2;
        }

        public function get keyword():String
        {
            return (_keyword);
        }

        public function get engine():String
        {
            return (_engine);
        }

        public function set engine(_arg_1:String):void
        {
            _engine = _arg_1.toLowerCase();
        }

        public function toString():String
        {
            return ((engine + "?") + keyword);
        }

        public function set keyword(_arg_1:String):void
        {
            _keyword = _arg_1.toLowerCase();
        }


    }
}//package com.google.analytics.core

