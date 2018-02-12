// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.BrowserInfo

package com.google.analytics.core
{
    import com.google.analytics.v4.Configuration;
    import com.google.analytics.utils.Environment;
    import com.google.analytics.utils.Variables;
    import com.google.analytics.utils.Version;

    public class BrowserInfo 
    {

        private var _config:Configuration;
        private var _info:Environment;

        public function BrowserInfo(_arg_1:Configuration, _arg_2:Environment)
        {
            _config = _arg_1;
            _info = _arg_2;
        }

        public function get utmul():String
        {
            return (_info.language.toLowerCase());
        }

        public function get utmje():String
        {
            return ("0");
        }

        public function toURLString():String
        {
            var _local_1:Variables = toVariables();
            return (_local_1.toString());
        }

        public function get utmsr():String
        {
            return ((_info.screenWidth + "x") + _info.screenHeight);
        }

        public function get utmfl():String
        {
            var _local_1:Version;
            if (_config.detectFlash)
            {
                _local_1 = _info.flashVersion;
                return ((((_local_1.major + ".") + _local_1.minor) + " r") + _local_1.build);
            };
            return ("-");
        }

        public function get utmcs():String
        {
            return (_info.languageEncoding);
        }

        public function toVariables():Variables
        {
            var _local_1:Variables = new Variables();
            _local_1.URIencode = true;
            _local_1.utmcs = utmcs;
            _local_1.utmsr = utmsr;
            _local_1.utmsc = utmsc;
            _local_1.utmul = utmul;
            _local_1.utmje = utmje;
            _local_1.utmfl = utmfl;
            return (_local_1);
        }

        public function get utmsc():String
        {
            return (_info.screenColorDepth + "-bit");
        }


    }
}//package com.google.analytics.core

