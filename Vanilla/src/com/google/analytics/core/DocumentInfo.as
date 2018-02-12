// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.DocumentInfo

package com.google.analytics.core
{
    import com.google.analytics.v4.Configuration;
    import com.google.analytics.external.AdSenseGlobals;
    import com.google.analytics.utils.Environment;
    import com.google.analytics.utils.Variables;

    public class DocumentInfo 
    {

        private var _pageURL:String;
        private var _utmr:String;
        private var _config:Configuration;
        private var _adSense:AdSenseGlobals;
        private var _info:Environment;

        public function DocumentInfo(_arg_1:Configuration, _arg_2:Environment, _arg_3:String, _arg_4:String=null, _arg_5:AdSenseGlobals=null)
        {
            _config = _arg_1;
            _info = _arg_2;
            _utmr = _arg_3;
            _pageURL = _arg_4;
            _adSense = _arg_5;
        }

        public function get utmr():String
        {
            if (!_utmr)
            {
                return ("-");
            };
            return (_utmr);
        }

        public function toURLString():String
        {
            var _local_1:Variables = toVariables();
            return (_local_1.toString());
        }

        private function _renderPageURL(_arg_1:String=""):String
        {
            var _local_2:String = _info.locationPath;
            var _local_3:String = _info.locationSearch;
            if (((!(_arg_1)) || (_arg_1 == "")))
            {
                _arg_1 = (_local_2 + unescape(_local_3));
                if (_arg_1 == "")
                {
                    _arg_1 = "/";
                };
            };
            return (_arg_1);
        }

        public function get utmp():String
        {
            return (_renderPageURL(_pageURL));
        }

        public function get utmhid():String
        {
            return (String(_generateHitId()));
        }

        private function _generateHitId():Number
        {
            var _local_1:Number;
            if (((_adSense.hid) && (!(_adSense.hid == ""))))
            {
                _local_1 = Number(_adSense.hid);
            }
            else
            {
                _local_1 = Math.round((Math.random() * 2147483647));
                _adSense.hid = String(_local_1);
            };
            return (_local_1);
        }

        public function toVariables():Variables
        {
            var _local_1:Variables = new Variables();
            _local_1.URIencode = true;
            if (((_config.detectTitle) && (!(utmdt == ""))))
            {
                _local_1.utmdt = utmdt;
            };
            _local_1.utmhid = utmhid;
            _local_1.utmr = utmr;
            _local_1.utmp = utmp;
            return (_local_1);
        }

        public function get utmdt():String
        {
            return (_info.documentTitle);
        }


    }
}//package com.google.analytics.core

