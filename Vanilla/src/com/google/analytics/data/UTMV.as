// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMV

package com.google.analytics.data
{
    import com.google.analytics.utils.Timespan;

    public class UTMV extends UTMCookie 
    {

        private var _domainHash:Number;
        private var _value:String;

        public function UTMV(_arg_1:Number=NaN, _arg_2:String="")
        {
            super("utmv", "__utmv", ["domainHash", "value"], (Timespan.twoyears * 1000));
            this.domainHash = _arg_1;
            this.value = _arg_2;
        }

        public function get value():String
        {
            return (_value);
        }

        public function get domainHash():Number
        {
            return (_domainHash);
        }

        public function set domainHash(_arg_1:Number):void
        {
            _domainHash = _arg_1;
            update();
        }

        public function set value(_arg_1:String):void
        {
            _value = _arg_1;
            update();
        }


    }
}//package com.google.analytics.data

