// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMK

package com.google.analytics.data
{
    public class UTMK extends UTMCookie 
    {

        private var _hash:Number;

        public function UTMK(_arg_1:Number=NaN)
        {
            super("utmk", "__utmk", ["hash"]);
            this.hash = _arg_1;
        }

        public function set hash(_arg_1:Number):void
        {
            _hash = _arg_1;
            update();
        }

        public function get hash():Number
        {
            return (_hash);
        }


    }
}//package com.google.analytics.data

