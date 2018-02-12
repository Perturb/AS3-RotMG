// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMA

package com.google.analytics.data
{
    import com.google.analytics.utils.Timespan;

    public class UTMA extends UTMCookie 
    {

        private var _sessionId:Number;
        private var _domainHash:Number;
        private var _firstTime:Number;
        private var _currentTime:Number;
        private var _lastTime:Number;
        private var _sessionCount:Number;

        public function UTMA(_arg_1:Number=NaN, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Number=NaN, _arg_5:Number=NaN, _arg_6:Number=NaN)
        {
            super("utma", "__utma", ["domainHash", "sessionId", "firstTime", "lastTime", "currentTime", "sessionCount"], (Timespan.twoyears * 1000));
            this.domainHash = _arg_1;
            this.sessionId = _arg_2;
            this.firstTime = _arg_3;
            this.lastTime = _arg_4;
            this.currentTime = _arg_5;
            this.sessionCount = _arg_6;
        }

        public function get lastTime():Number
        {
            return (_lastTime);
        }

        public function set lastTime(_arg_1:Number):void
        {
            _lastTime = _arg_1;
            update();
        }

        public function set currentTime(_arg_1:Number):void
        {
            _currentTime = _arg_1;
            update();
        }

        public function get sessionId():Number
        {
            return (_sessionId);
        }

        public function get sessionCount():Number
        {
            return (_sessionCount);
        }

        public function get firstTime():Number
        {
            return (_firstTime);
        }

        public function get currentTime():Number
        {
            return (_currentTime);
        }

        public function set domainHash(_arg_1:Number):void
        {
            _domainHash = _arg_1;
            update();
        }

        public function set sessionId(_arg_1:Number):void
        {
            _sessionId = _arg_1;
            update();
        }

        public function set sessionCount(_arg_1:Number):void
        {
            _sessionCount = _arg_1;
            update();
        }

        public function get domainHash():Number
        {
            return (_domainHash);
        }

        public function set firstTime(_arg_1:Number):void
        {
            _firstTime = _arg_1;
            update();
        }


    }
}//package com.google.analytics.data

