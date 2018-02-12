// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMC

package com.google.analytics.data
{
    public class UTMC extends UTMCookie 
    {

        private var _domainHash:Number;

        public function UTMC(_arg_1:Number=NaN)
        {
            super("utmc", "__utmc", ["domainHash"]);
            this.domainHash = _arg_1;
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


    }
}//package com.google.analytics.data

