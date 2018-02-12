// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMB

package com.google.analytics.data
{
    import com.google.analytics.utils.Timespan;

    public class UTMB extends UTMCookie 
    {

        public static var defaultTimespan:Number = Timespan.thirtyminutes;

        private var _trackCount:Number;
        private var _lastTime:Number;
        private var _domainHash:Number;
        private var _token:Number;

        public function UTMB(_arg_1:Number=NaN, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Number=NaN)
        {
            super("utmb", "__utmb", ["domainHash", "trackCount", "token", "lastTime"], (defaultTimespan * 1000));
            this.domainHash = _arg_1;
            this.trackCount = _arg_2;
            this.token = _arg_3;
            this.lastTime = _arg_4;
        }

        public function set token(_arg_1:Number):void
        {
            _token = _arg_1;
            update();
        }

        public function set trackCount(_arg_1:Number):void
        {
            _trackCount = _arg_1;
            update();
        }

        public function get lastTime():Number
        {
            return (_lastTime);
        }

        public function set domainHash(_arg_1:Number):void
        {
            _domainHash = _arg_1;
            update();
        }

        public function set lastTime(_arg_1:Number):void
        {
            _lastTime = _arg_1;
            update();
        }

        public function get domainHash():Number
        {
            return (_domainHash);
        }

        public function get token():Number
        {
            return (_token);
        }

        public function get trackCount():Number
        {
            return (_trackCount);
        }


    }
}//package com.google.analytics.data

