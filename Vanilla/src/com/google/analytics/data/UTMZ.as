// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMZ

package com.google.analytics.data
{
    import com.google.analytics.utils.Timespan;

    public class UTMZ extends UTMCookie 
    {

        public static var defaultTimespan:Number = Timespan.sixmonths;

        private var _campaignTracking:String;
        private var _campaignCreation:Number;
        private var _responseCount:Number;
        private var _domainHash:Number;
        private var _campaignSessions:Number;

        public function UTMZ(_arg_1:Number=NaN, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Number=NaN, _arg_5:String="")
        {
            super("utmz", "__utmz", ["domainHash", "campaignCreation", "campaignSessions", "responseCount", "campaignTracking"], (defaultTimespan * 1000));
            this.domainHash = _arg_1;
            this.campaignCreation = _arg_2;
            this.campaignSessions = _arg_3;
            this.responseCount = _arg_4;
            this.campaignTracking = _arg_5;
        }

        public function set responseCount(_arg_1:Number):void
        {
            _responseCount = _arg_1;
            update();
        }

        public function set domainHash(_arg_1:Number):void
        {
            _domainHash = _arg_1;
            update();
        }

        public function set campaignCreation(_arg_1:Number):void
        {
            _campaignCreation = _arg_1;
            update();
        }

        public function get campaignTracking():String
        {
            return (_campaignTracking);
        }

        public function get campaignSessions():Number
        {
            return (_campaignSessions);
        }

        public function get domainHash():Number
        {
            return (_domainHash);
        }

        public function get responseCount():Number
        {
            return (_responseCount);
        }

        public function get campaignCreation():Number
        {
            return (_campaignCreation);
        }

        public function set campaignSessions(_arg_1:Number):void
        {
            _campaignSessions = _arg_1;
            update();
        }

        public function set campaignTracking(_arg_1:String):void
        {
            _campaignTracking = _arg_1;
            update();
        }


    }
}//package com.google.analytics.data

