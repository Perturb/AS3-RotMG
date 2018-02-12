// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.utils.Environment

package com.google.analytics.utils
{
    import com.google.analytics.external.HTMLDOM;
    import com.google.analytics.debug.DebugConfiguration;
    import flash.system.Security;
    import flash.system.Capabilities;
    import flash.system.System;
    import com.google.analytics.core.ga_internal;

    use namespace ga_internal;

    public class Environment 
    {

        private var _dom:HTMLDOM;
        private var _appName:String;
        private var _debug:DebugConfiguration;
        private var _appVersion:Version;
        private var _url:String;
        private var _protocol:Protocols;
        private var _userAgent:UserAgent;

        public function Environment(_arg_1:String="", _arg_2:String="", _arg_3:String="", _arg_4:DebugConfiguration=null, _arg_5:HTMLDOM=null)
        {
            var _local_6:Version;
            super();
            if (_arg_2 == "")
            {
                if (isAIR())
                {
                    _arg_2 = "AIR";
                }
                else
                {
                    _arg_2 = "Flash";
                };
            };
            if (_arg_3 == "")
            {
                _local_6 = flashVersion;
            }
            else
            {
                _local_6 = Version.fromString(_arg_3);
            };
            _url = _arg_1;
            _appName = _arg_2;
            _appVersion = _local_6;
            _debug = _arg_4;
            _dom = _arg_5;
        }

        public function isAIR():Boolean
        {
            return ((playerType == "Desktop") && (Security.sandboxType.toString() == "application"));
        }

        public function get screenWidth():Number
        {
            return (Capabilities.screenResolutionX);
        }

        public function get playerType():String
        {
            return (Capabilities.playerType);
        }

        public function get locationSearch():String
        {
            var _local_1:String = _dom.search;
            if (_local_1)
            {
                return (_local_1);
            };
            return ("");
        }

        public function get protocol():Protocols
        {
            if (!_protocol)
            {
                _findProtocol();
            };
            return (_protocol);
        }

        public function get flashVersion():Version
        {
            return (Version.fromString(Capabilities.version.split(" ")[1], ","));
        }

        public function get userAgent():UserAgent
        {
            if (!_userAgent)
            {
                _userAgent = new UserAgent(this, appName, appVersion.toString(4));
            };
            return (_userAgent);
        }

        public function get languageEncoding():String
        {
            var _local_1:String;
            if (System.useCodePage)
            {
                _local_1 = _dom.characterSet;
                if (_local_1)
                {
                    return (_local_1);
                };
                return ("-");
            };
            return ("UTF-8");
        }

        public function get appName():String
        {
            return (_appName);
        }

        public function get screenColorDepth():String
        {
            var _local_1:String;
            switch (Capabilities.screenColor)
            {
                case "bw":
                    _local_1 = "1";
                    break;
                case "gray":
                    _local_1 = "2";
                    break;
                case "color":
                default:
                    _local_1 = "24";
            };
            var _local_2:String = _dom.colorDepth;
            if (_local_2)
            {
                _local_1 = _local_2;
            };
            return (_local_1);
        }

        private function _findProtocol():void
        {
            var _local_4:String;
            var _local_5:String;
            var _local_1:Protocols = Protocols.none;
            if (_url != "")
            {
                _local_4 = _url.toLowerCase();
                _local_5 = _local_4.substr(0, 5);
                switch (_local_5)
                {
                    case "file:":
                        _local_1 = Protocols.file;
                        break;
                    case "http:":
                        _local_1 = Protocols.HTTP;
                        break;
                    case "https":
                        if (_local_4.charAt(5) == ":")
                        {
                            _local_1 = Protocols.HTTPS;
                        };
                        break;
                    default:
                        _protocol = Protocols.none;
                };
            };
            var _local_2:String = _dom.protocol;
            var _local_3:String = (_local_1.toString() + ":").toLowerCase();
            if ((((_local_2) && (!(_local_2 == _local_3))) && (_debug)))
            {
                _debug.warning(((("Protocol mismatch: SWF=" + _local_3) + ", DOM=") + _local_2));
            };
            _protocol = _local_1;
        }

        public function get locationSWFPath():String
        {
            return (_url);
        }

        public function get platform():String
        {
            var _local_1:String = Capabilities.manufacturer;
            return (_local_1.split("Adobe ")[1]);
        }

        public function get operatingSystem():String
        {
            return (Capabilities.os);
        }

        public function set appName(_arg_1:String):void
        {
            _appName = _arg_1;
            userAgent.applicationProduct = _arg_1;
        }

        ga_internal function set url(_arg_1:String):void
        {
            _url = _arg_1;
        }

        public function get referrer():String
        {
            var _local_1:String = _dom.referrer;
            if (_local_1)
            {
                return (_local_1);
            };
            if (protocol == Protocols.file)
            {
                return ("localhost");
            };
            return ("");
        }

        public function isInHTML():Boolean
        {
            return (Capabilities.playerType == "PlugIn");
        }

        public function get language():String
        {
            var _local_1:String = _dom.language;
            var _local_2:String = Capabilities.language;
            if (_local_1)
            {
                if (((_local_1.length > _local_2.length) && (_local_1.substr(0, _local_2.length) == _local_2)))
                {
                    _local_2 = _local_1;
                };
            };
            return (_local_2);
        }

        public function get domainName():String
        {
            var _local_1:String;
            var _local_2:String;
            var _local_3:int;
            if (((protocol == Protocols.HTTP) || (protocol == Protocols.HTTPS)))
            {
                _local_1 = _url.toLowerCase();
                if (protocol == Protocols.HTTP)
                {
                    _local_2 = _local_1.split("http://").join("");
                }
                else
                {
                    if (protocol == Protocols.HTTPS)
                    {
                        _local_2 = _local_1.split("https://").join("");
                    };
                };
                _local_3 = _local_2.indexOf("/");
                if (_local_3 > -1)
                {
                    _local_2 = _local_2.substring(0, _local_3);
                };
                return (_local_2);
            };
            if (protocol == Protocols.file)
            {
                return ("localhost");
            };
            return ("");
        }

        public function set userAgent(_arg_1:UserAgent):void
        {
            _userAgent = _arg_1;
        }

        public function set appVersion(_arg_1:Version):void
        {
            _appVersion = _arg_1;
            userAgent.applicationVersion = _arg_1.toString(4);
        }

        public function get screenHeight():Number
        {
            return (Capabilities.screenResolutionY);
        }

        public function get locationPath():String
        {
            var _local_1:String = _dom.pathname;
            if (_local_1)
            {
                return (_local_1);
            };
            return ("");
        }

        public function get documentTitle():String
        {
            var _local_1:String = _dom.title;
            if (_local_1)
            {
                return (_local_1);
            };
            return ("");
        }

        public function get appVersion():Version
        {
            return (_appVersion);
        }


    }
}//package com.google.analytics.utils

