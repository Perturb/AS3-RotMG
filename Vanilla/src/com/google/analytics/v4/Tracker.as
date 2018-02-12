// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.v4.Tracker

package com.google.analytics.v4
{
    import com.google.analytics.external.AdSenseGlobals;
    import com.google.analytics.data.X10;
    import com.google.analytics.core.BrowserInfo;
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.core.Buffer;
    import com.google.analytics.campaign.CampaignManager;
    import com.google.analytics.utils.Environment;
    import com.google.analytics.campaign.CampaignInfo;
    import com.google.analytics.core.GIFRequest;
    import com.google.analytics.core.Ecommerce;
    import com.google.analytics.core.Utils;
    import com.google.analytics.utils.Protocols;
    import com.google.analytics.debug.VisualDebugMode;
    import com.google.analytics.ecommerce.Transaction;
    import com.google.analytics.utils.Variables;
    import com.google.analytics.core.EventInfo;
    import com.google.analytics.utils.URL;
    import com.google.analytics.core.EventTracker;
    import com.google.analytics.core.DomainNameMode;
    import com.google.analytics.core.DocumentInfo;
    import com.google.analytics.core.ServerOperationMode;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    public class Tracker implements GoogleAnalyticsAPI 
    {

        private const EVENT_TRACKER_LABEL_KEY_NUM:int = 3;
        private const EVENT_TRACKER_VALUE_VALUE_NUM:int = 1;
        private const EVENT_TRACKER_PROJECT_ID:int = 5;
        private const EVENT_TRACKER_OBJECT_NAME_KEY_NUM:int = 1;
        private const EVENT_TRACKER_TYPE_KEY_NUM:int = 2;

        private var _adSense:AdSenseGlobals;
        private var _eventTracker:X10;
        private var _noSessionInformation:Boolean = false;
        private var _browserInfo:BrowserInfo;
        private var _debug:DebugConfiguration;
        private var _isNewVisitor:Boolean = false;
        private var _buffer:Buffer;
        private var _config:Configuration;
        private var _x10Module:X10;
        private var _campaign:CampaignManager;
        private var _formatedReferrer:String;
        private var _timeStamp:Number;
        private var _info:Environment;
        private var _domainHash:Number;
        private var _campaignInfo:CampaignInfo;
        private var _gifRequest:GIFRequest;
        private var _hasInitData:Boolean = false;
        private var _ecom:Ecommerce;
        private var _account:String;

        public function Tracker(_arg_1:String, _arg_2:Configuration, _arg_3:DebugConfiguration, _arg_4:Environment, _arg_5:Buffer, _arg_6:GIFRequest, _arg_7:AdSenseGlobals, _arg_8:Ecommerce)
        {
            var _local_9:String;
            super();
            _account = _arg_1;
            _config = _arg_2;
            _debug = _arg_3;
            _info = _arg_4;
            _buffer = _arg_5;
            _gifRequest = _arg_6;
            _adSense = _arg_7;
            _ecom = _arg_8;
            if (!Utils.validateAccount(_arg_1))
            {
                _local_9 = (('Account "' + _arg_1) + '" is not valid.');
                _debug.warning(_local_9);
                throw (new Error(_local_9));
            };
        }

        private function _doTracking():Boolean
        {
            if ((((!(_info.protocol == Protocols.file)) && (!(_info.protocol == Protocols.none))) && (_isNotGoogleSearch())))
            {
                return (true);
            };
            if (_config.allowLocalTracking)
            {
                return (true);
            };
            return (false);
        }

        public function addOrganic(_arg_1:String, _arg_2:String):void
        {
            _debug.info((("addOrganic( " + [_arg_1, _arg_2].join(", ")) + " )"));
            _config.organic.addSource(_arg_1, _arg_2);
        }

        public function setAllowLinker(_arg_1:Boolean):void
        {
            _config.allowLinker = _arg_1;
            _debug.info((("setAllowLinker( " + _config.allowLinker) + " )"));
        }

        public function getLinkerUrl(_arg_1:String="", _arg_2:Boolean=false):String
        {
            _initData();
            _debug.info((((("getLinkerUrl( " + _arg_1) + ", ") + _arg_2.toString()) + " )"));
            return (_buffer.getLinkerUrl(_arg_1, _arg_2));
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:Number=NaN):Boolean
        {
            _initData();
            var _local_5:Boolean = true;
            var _local_6:int = 2;
            if (((!(_arg_1 == "")) && (!(_arg_2 == ""))))
            {
                _eventTracker.clearKey(EVENT_TRACKER_PROJECT_ID);
                _eventTracker.clearValue(EVENT_TRACKER_PROJECT_ID);
                _local_5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID, EVENT_TRACKER_OBJECT_NAME_KEY_NUM, _arg_1);
                _local_5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID, EVENT_TRACKER_TYPE_KEY_NUM, _arg_2);
                if (_arg_3)
                {
                    _local_5 = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID, EVENT_TRACKER_LABEL_KEY_NUM, _arg_3);
                    _local_6 = 3;
                };
                if (!isNaN(_arg_4))
                {
                    _local_5 = _eventTracker.setValue(EVENT_TRACKER_PROJECT_ID, EVENT_TRACKER_VALUE_VALUE_NUM, _arg_4);
                    _local_6 = 4;
                };
                if (_local_5)
                {
                    _debug.info(((("valid event tracking call\ncategory: " + _arg_1) + "\naction: ") + _arg_2), VisualDebugMode.geek);
                    _sendXEvent(_eventTracker);
                };
            }
            else
            {
                _debug.warning(((("event tracking call is not valid, failed!\ncategory: " + _arg_1) + "\naction: ") + _arg_2), VisualDebugMode.geek);
                _local_5 = false;
            };
            switch (_local_6)
            {
                case 4:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2, _arg_3, _arg_4].join(", ")) + " )"));
                    break;
                case 3:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2, _arg_3].join(", ")) + " )"));
                    break;
                case 2:
                default:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2].join(", ")) + " )"));
            };
            return (_local_5);
        }

        public function trackPageview(_arg_1:String=""):void
        {
            _debug.info((("trackPageview( " + _arg_1) + " )"));
            if (_doTracking())
            {
                _initData();
                _trackMetrics(_arg_1);
                _noSessionInformation = false;
            }
            else
            {
                _debug.warning((("trackPageview( " + _arg_1) + " ) failed"));
            };
        }

        public function setCookieTimeout(_arg_1:int):void
        {
            _config.conversionTimeout = _arg_1;
            _debug.info((("setCookieTimeout( " + _config.conversionTimeout) + " )"));
        }

        public function trackTrans():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_4:Transaction;
            _initData();
            var _local_3:Array = new Array();
            if (_takeSample())
            {
                _local_1 = 0;
                while (_local_1 < _ecom.getTransLength())
                {
                    _local_4 = _ecom.getTransFromArray(_local_1);
                    _local_3.push(_local_4.toGifParams());
                    _local_2 = 0;
                    while (_local_2 < _local_4.getItemsLength())
                    {
                        _local_3.push(_local_4.getItemFromArray(_local_2).toGifParams());
                        _local_2++;
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (_local_1 < _local_3.length)
                {
                    _gifRequest.send(_account, _local_3[_local_1]);
                    _local_1++;
                };
            };
        }

        public function setClientInfo(_arg_1:Boolean):void
        {
            _config.detectClientInfo = _arg_1;
            _debug.info((("setClientInfo( " + _config.detectClientInfo) + " )"));
        }

        public function linkByPost(_arg_1:Object, _arg_2:Boolean=false):void
        {
            _debug.warning("linkByPost not implemented in AS3 mode");
        }

        private function _initData():void
        {
            var _local_1:String;
            var _local_2:String;
            if (!_hasInitData)
            {
                _updateDomainName();
                _domainHash = _getDomainHash();
                _timeStamp = Math.round((new Date().getTime() / 1000));
                if (_debug.verbose)
                {
                    _local_1 = "";
                    _local_1 = (_local_1 + "_initData 0");
                    _local_1 = (_local_1 + ("\ndomain name: " + _config.domainName));
                    _local_1 = (_local_1 + ("\ndomain hash: " + _domainHash));
                    _local_1 = (_local_1 + (((("\ntimestamp:   " + _timeStamp) + " (") + new Date((_timeStamp * 1000))) + ")"));
                    _debug.info(_local_1, VisualDebugMode.geek);
                };
            };
            if (_doTracking())
            {
                _handleCookie();
            };
            if (!_hasInitData)
            {
                if (_doTracking())
                {
                    _formatedReferrer = _formatReferrer();
                    _browserInfo = new BrowserInfo(_config, _info);
                    _debug.info(("browserInfo: " + _browserInfo.toURLString()), VisualDebugMode.advanced);
                    if (_config.campaignTracking)
                    {
                        _campaign = new CampaignManager(_config, _debug, _buffer, _domainHash, _formatedReferrer, _timeStamp);
                        _campaignInfo = _campaign.getCampaignInformation(_info.locationSearch, _noSessionInformation);
                        _debug.info(("campaignInfo: " + _campaignInfo.toURLString()), VisualDebugMode.advanced);
                        _debug.info(("Search: " + _info.locationSearch));
                        _debug.info(("CampaignTrackig: " + _buffer.utmz.campaignTracking));
                    };
                };
                _x10Module = new X10();
                _eventTracker = new X10();
                _hasInitData = true;
            };
            if (_config.hasSiteOverlay)
            {
                _debug.warning("Site Overlay is not supported");
            };
            if (_debug.verbose)
            {
                _local_2 = "";
                _local_2 = (_local_2 + "_initData (misc)");
                _local_2 = (_local_2 + ("\nflash version: " + _info.flashVersion.toString(4)));
                _local_2 = (_local_2 + ("\nprotocol: " + _info.protocol));
                _local_2 = (_local_2 + (('\ndefault domain name (auto): "' + _info.domainName) + '"'));
                _local_2 = (_local_2 + ("\nlanguage: " + _info.language));
                _local_2 = (_local_2 + ("\ndomain hash: " + _getDomainHash()));
                _local_2 = (_local_2 + ("\nuser-agent: " + _info.userAgent));
                _debug.info(_local_2, VisualDebugMode.geek);
            };
        }

        public function getDetectTitle():Boolean
        {
            _debug.info("getDetectTitle()");
            return (_config.detectTitle);
        }

        public function resetSession():void
        {
            _debug.info("resetSession()");
            _buffer.resetCurrentSession();
        }

        public function getClientInfo():Boolean
        {
            _debug.info("getClientInfo()");
            return (_config.detectClientInfo);
        }

        private function _sendXEvent(_arg_1:X10=null):void
        {
            var _local_2:Variables;
            var _local_3:EventInfo;
            var _local_4:Variables;
            var _local_5:Variables;
            if (_takeSample())
            {
                _local_2 = new Variables();
                _local_2.URIencode = true;
                _local_3 = new EventInfo(true, _x10Module, _arg_1);
                _local_4 = _local_3.toVariables();
                _local_5 = _renderMetricsSearchVariables();
                _local_2.join(_local_4, _local_5);
                _gifRequest.send(_account, _local_2, false, true);
            };
        }

        public function setDetectFlash(_arg_1:Boolean):void
        {
            _config.detectFlash = _arg_1;
            _debug.info((("setDetectFlash( " + _config.detectFlash) + " )"));
        }

        public function setCampNameKey(_arg_1:String):void
        {
            _config.campaignKey.UCCN = _arg_1;
            var _local_2:* = (("setCampNameKey( " + _config.campaignKey.UCCN) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCCN]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        private function _formatReferrer():String
        {
            var _local_2:String;
            var _local_3:URL;
            var _local_4:URL;
            var _local_1:String = _info.referrer;
            if (((_local_1 == "") || (_local_1 == "localhost")))
            {
                _local_1 = "-";
            }
            else
            {
                _local_2 = _info.domainName;
                _local_3 = new URL(_local_1);
                _local_4 = new URL(("http://" + _local_2));
                if (_local_3.hostName == _local_2)
                {
                    return ("-");
                };
                if (_local_4.domain == _local_3.domain)
                {
                    if (_local_4.subDomain != _local_3.subDomain)
                    {
                        _local_1 = "0";
                    };
                };
                if (((_local_1.charAt(0) == "[") && (_local_1.charAt((_local_1.length - 1)))))
                {
                    _local_1 = "-";
                };
            };
            _debug.info(("formated referrer: " + _local_1), VisualDebugMode.advanced);
            return (_local_1);
        }

        private function _visitCode():Number
        {
            if (_debug.verbose)
            {
                _debug.info(("visitCode: " + _buffer.utma.sessionId), VisualDebugMode.geek);
            };
            return (_buffer.utma.sessionId);
        }

        public function createEventTracker(_arg_1:String):EventTracker
        {
            _debug.info((("createEventTracker( " + _arg_1) + " )"));
            return (new EventTracker(_arg_1, this));
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:int):void
        {
            var _local_7:Transaction;
            _local_7 = _ecom.getTransaction(_arg_1);
            if (_local_7 == null)
            {
                _local_7 = _ecom.addTransaction(_arg_1, "", "", "", "", "", "", "");
            };
            _local_7.addItem(_arg_2, _arg_3, _arg_4, _arg_5.toString(), _arg_6.toString());
            if (_debug.active)
            {
                _debug.info((("addItem( " + [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6].join(", ")) + " )"));
            };
        }

        public function clearIgnoredOrganic():void
        {
            _debug.info("clearIgnoredOrganic()");
            _config.organic.clearIgnoredKeywords();
        }

        public function setVar(_arg_1:String):void
        {
            var _local_2:Variables;
            if (((!(_arg_1 == "")) && (_isNotGoogleSearch())))
            {
                _initData();
                _buffer.utmv.domainHash = _domainHash;
                _buffer.utmv.value = encodeURI(_arg_1);
                if (_debug.verbose)
                {
                    _debug.info(_buffer.utmv.toString(), VisualDebugMode.geek);
                };
                _debug.info((("setVar( " + _arg_1) + " )"));
                if (_takeSample())
                {
                    _local_2 = new Variables();
                    _local_2.utmt = "var";
                    _gifRequest.send(_account, _local_2);
                };
            }
            else
            {
                _debug.warning((('setVar "' + _arg_1) + '" is ignored'));
            };
        }

        public function setDomainName(_arg_1:String):void
        {
            if (_arg_1 == "auto")
            {
                _config.domain.mode = DomainNameMode.auto;
            }
            else
            {
                if (_arg_1 == "none")
                {
                    _config.domain.mode = DomainNameMode.none;
                }
                else
                {
                    _config.domain.mode = DomainNameMode.custom;
                    _config.domain.name = _arg_1;
                };
            };
            _updateDomainName();
            _debug.info((("setDomainName( " + _config.domainName) + " )"));
        }

        private function _updateDomainName():void
        {
            var _local_1:String;
            if (_config.domain.mode == DomainNameMode.auto)
            {
                _local_1 = _info.domainName;
                if (_local_1.substring(0, 4) == "www.")
                {
                    _local_1 = _local_1.substring(4);
                };
                _config.domain.name = _local_1;
            };
            _config.domainName = _config.domain.name.toLowerCase();
            _debug.info(("domain name: " + _config.domainName), VisualDebugMode.advanced);
        }

        public function addTrans(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:String, _arg_7:String, _arg_8:String):void
        {
            _ecom.addTransaction(_arg_1, _arg_2, _arg_3.toString(), _arg_4.toString(), _arg_5.toString(), _arg_6, _arg_7, _arg_8);
            if (_debug.active)
            {
                _debug.info((("addTrans( " + [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8].join(", ")) + " );"));
            };
        }

        private function _renderMetricsSearchVariables(_arg_1:String=""):Variables
        {
            var _local_4:Variables;
            var _local_2:Variables = new Variables();
            _local_2.URIencode = true;
            var _local_3:DocumentInfo = new DocumentInfo(_config, _info, _formatedReferrer, _arg_1, _adSense);
            _debug.info(("docInfo: " + _local_3.toURLString()), VisualDebugMode.geek);
            if (_config.campaignTracking)
            {
                _local_4 = _campaignInfo.toVariables();
            };
            var _local_5:Variables = _browserInfo.toVariables();
            _local_2.join(_local_3.toVariables(), _local_5, _local_4);
            return (_local_2);
        }

        public function setCampContentKey(_arg_1:String):void
        {
            _config.campaignKey.UCCT = _arg_1;
            var _local_2:* = (("setCampContentKey( " + _config.campaignKey.UCCT) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCCT]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        private function _handleCookie():void
        {
            var _local_1:String;
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            if (_config.allowLinker)
            {
            };
            _buffer.createSO();
            if (((_buffer.hasUTMA()) && (!(_buffer.utma.isEmpty()))))
            {
                if (((!(_buffer.hasUTMB())) || (!(_buffer.hasUTMC()))))
                {
                    _buffer.updateUTMA(_timeStamp);
                    _noSessionInformation = true;
                };
                if (_debug.verbose)
                {
                    _debug.info(("from cookie " + _buffer.utma.toString()), VisualDebugMode.geek);
                };
            }
            else
            {
                _debug.info("create a new utma", VisualDebugMode.advanced);
                _buffer.utma.domainHash = _domainHash;
                _buffer.utma.sessionId = _getUniqueSessionId();
                _buffer.utma.firstTime = _timeStamp;
                _buffer.utma.lastTime = _timeStamp;
                _buffer.utma.currentTime = _timeStamp;
                _buffer.utma.sessionCount = 1;
                if (_debug.verbose)
                {
                    _debug.info(_buffer.utma.toString(), VisualDebugMode.geek);
                };
                _noSessionInformation = true;
                _isNewVisitor = true;
            };
            if (((_adSense.gaGlobal) && (_adSense.dh == String(_domainHash))))
            {
                if (_adSense.sid)
                {
                    _buffer.utma.currentTime = Number(_adSense.sid);
                    if (_debug.verbose)
                    {
                        _local_1 = "";
                        _local_1 = (_local_1 + "AdSense sid found\n");
                        _local_1 = (_local_1 + (((("Override currentTime(" + _buffer.utma.currentTime) + ") from AdSense sid(") + Number(_adSense.sid)) + ")"));
                        _debug.info(_local_1, VisualDebugMode.geek);
                    };
                };
                if (_isNewVisitor)
                {
                    if (_adSense.sid)
                    {
                        _buffer.utma.lastTime = Number(_adSense.sid);
                        if (_debug.verbose)
                        {
                            _local_2 = "";
                            _local_2 = (_local_2 + "AdSense sid found (new visitor)\n");
                            _local_2 = (_local_2 + (((("Override lastTime(" + _buffer.utma.lastTime) + ") from AdSense sid(") + Number(_adSense.sid)) + ")"));
                            _debug.info(_local_2, VisualDebugMode.geek);
                        };
                    };
                    if (_adSense.vid)
                    {
                        _local_3 = _adSense.vid.split(".");
                        _buffer.utma.sessionId = Number(_local_3[0]);
                        _buffer.utma.firstTime = Number(_local_3[1]);
                        if (_debug.verbose)
                        {
                            _local_4 = "";
                            _local_4 = (_local_4 + "AdSense vid found (new visitor)\n");
                            _local_4 = (_local_4 + (((("Override sessionId(" + _buffer.utma.sessionId) + ") from AdSense vid(") + Number(_local_3[0])) + ")\n"));
                            _local_4 = (_local_4 + (((("Override firstTime(" + _buffer.utma.firstTime) + ") from AdSense vid(") + Number(_local_3[1])) + ")"));
                            _debug.info(_local_4, VisualDebugMode.geek);
                        };
                    };
                    if (_debug.verbose)
                    {
                        _debug.info(("AdSense modified : " + _buffer.utma.toString()), VisualDebugMode.geek);
                    };
                };
            };
            _buffer.utmb.domainHash = _domainHash;
            if (isNaN(_buffer.utmb.trackCount))
            {
                _buffer.utmb.trackCount = 0;
            };
            if (isNaN(_buffer.utmb.token))
            {
                _buffer.utmb.token = _config.tokenCliff;
            };
            if (isNaN(_buffer.utmb.lastTime))
            {
                _buffer.utmb.lastTime = _buffer.utma.currentTime;
            };
            _buffer.utmc.domainHash = _domainHash;
            if (_debug.verbose)
            {
                _debug.info(_buffer.utmb.toString(), VisualDebugMode.advanced);
                _debug.info(_buffer.utmc.toString(), VisualDebugMode.advanced);
            };
        }

        public function setLocalServerMode():void
        {
            _config.serverMode = ServerOperationMode.local;
            _debug.info("setLocalServerMode()");
        }

        public function clearIgnoredRef():void
        {
            _debug.info("clearIgnoredRef()");
            _config.organic.clearIgnoredReferrals();
        }

        public function setCampSourceKey(_arg_1:String):void
        {
            _config.campaignKey.UCSR = _arg_1;
            var _local_2:* = (("setCampSourceKey( " + _config.campaignKey.UCSR) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCSR]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        public function getLocalGifPath():String
        {
            _debug.info("getLocalGifPath()");
            return (_config.localGIFpath);
        }

        public function setLocalGifPath(_arg_1:String):void
        {
            _config.localGIFpath = _arg_1;
            _debug.info((("setLocalGifPath( " + _config.localGIFpath) + " )"));
        }

        public function getVersion():String
        {
            _debug.info("getVersion()");
            return (_config.version);
        }

        public function setAllowAnchor(_arg_1:Boolean):void
        {
            _config.allowAnchor = _arg_1;
            _debug.info((("setAllowAnchor( " + _config.allowAnchor) + " )"));
        }

        private function _isNotGoogleSearch():Boolean
        {
            var _local_1:String = _config.domainName;
            var _local_2:* = (_local_1.indexOf("www.google.") < 0);
            var _local_3:* = (_local_1.indexOf(".google.") < 0);
            var _local_4:* = (_local_1.indexOf("google.") < 0);
            var _local_5:* = (_local_1.indexOf("google.org") > -1);
            return (((((_local_2) || (_local_3)) || (_local_4)) || (!(_config.cookiePath == "/"))) || (_local_5));
        }

        public function setSampleRate(_arg_1:Number):void
        {
            if (_arg_1 < 0)
            {
                _debug.warning("sample rate can not be negative, ignoring value.");
            }
            else
            {
                _config.sampleRate = _arg_1;
            };
            _debug.info((("setSampleRate( " + _config.sampleRate) + " )"));
        }

        private function _takeSample():Boolean
        {
            if (_debug.verbose)
            {
                _debug.info((((("takeSample: (" + (_visitCode() % 10000)) + ") < (") + (_config.sampleRate * 10000)) + ")"), VisualDebugMode.geek);
            };
            return ((_visitCode() % 10000) < (_config.sampleRate * 10000));
        }

        public function setCookiePath(_arg_1:String):void
        {
            _config.cookiePath = _arg_1;
            _debug.info((("setCookiePath( " + _config.cookiePath) + " )"));
        }

        public function setAllowHash(_arg_1:Boolean):void
        {
            _config.allowDomainHash = _arg_1;
            _debug.info((("setAllowHash( " + _config.allowDomainHash) + " )"));
        }

        private function _generateUserDataHash():Number
        {
            var _local_1:* = "";
            _local_1 = (_local_1 + _info.appName);
            _local_1 = (_local_1 + _info.appVersion);
            _local_1 = (_local_1 + _info.language);
            _local_1 = (_local_1 + _info.platform);
            _local_1 = (_local_1 + _info.userAgent.toString());
            _local_1 = (_local_1 + (((_info.screenWidth + "x") + _info.screenHeight) + _info.screenColorDepth));
            _local_1 = (_local_1 + _info.referrer);
            return (Utils.generateHash(_local_1));
        }

        public function setCampNOKey(_arg_1:String):void
        {
            _config.campaignKey.UCNO = _arg_1;
            var _local_2:* = (("setCampNOKey( " + _config.campaignKey.UCNO) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCNO]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        public function addIgnoredOrganic(_arg_1:String):void
        {
            _debug.info((("addIgnoredOrganic( " + _arg_1) + " )"));
            _config.organic.addIgnoredKeyword(_arg_1);
        }

        public function setLocalRemoteServerMode():void
        {
            _config.serverMode = ServerOperationMode.both;
            _debug.info("setLocalRemoteServerMode()");
        }

        public function cookiePathCopy(_arg_1:String):void
        {
            _debug.warning((("cookiePathCopy( " + _arg_1) + " ) not implemented"));
        }

        public function setDetectTitle(_arg_1:Boolean):void
        {
            _config.detectTitle = _arg_1;
            _debug.info((("setDetectTitle( " + _config.detectTitle) + " )"));
        }

        public function setCampTermKey(_arg_1:String):void
        {
            _config.campaignKey.UCTR = _arg_1;
            var _local_2:* = (("setCampTermKey( " + _config.campaignKey.UCTR) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCTR]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        public function getServiceMode():ServerOperationMode
        {
            _debug.info("getServiceMode()");
            return (_config.serverMode);
        }

        private function _trackMetrics(_arg_1:String=""):void
        {
            var _local_2:Variables;
            var _local_3:Variables;
            var _local_4:Variables;
            var _local_5:EventInfo;
            if (_takeSample())
            {
                _local_2 = new Variables();
                _local_2.URIencode = true;
                if (((_x10Module) && (_x10Module.hasData())))
                {
                    _local_5 = new EventInfo(false, _x10Module);
                    _local_3 = _local_5.toVariables();
                };
                _local_4 = _renderMetricsSearchVariables(_arg_1);
                _local_2.join(_local_3, _local_4);
                _gifRequest.send(_account, _local_2);
            };
        }

        public function setCampaignTrack(_arg_1:Boolean):void
        {
            _config.campaignTracking = _arg_1;
            _debug.info((("setCampaignTrack( " + _config.campaignTracking) + " )"));
        }

        public function addIgnoredRef(_arg_1:String):void
        {
            _debug.info((("addIgnoredRef( " + _arg_1) + " )"));
            _config.organic.addIgnoredReferral(_arg_1);
        }

        public function clearOrganic():void
        {
            _debug.info("clearOrganic()");
            _config.organic.clearEngines();
        }

        public function getDetectFlash():Boolean
        {
            _debug.info("getDetectFlash()");
            return (_config.detectFlash);
        }

        public function setCampMediumKey(_arg_1:String):void
        {
            _config.campaignKey.UCMD = _arg_1;
            var _local_2:* = (("setCampMediumKey( " + _config.campaignKey.UCMD) + " )");
            if (_debug.mode == VisualDebugMode.geek)
            {
                _debug.info((_local_2 + " [UCMD]"));
            }
            else
            {
                _debug.info(_local_2);
            };
        }

        private function _getUniqueSessionId():Number
        {
            var _local_1:Number = ((Utils.generate32bitRandom() ^ _generateUserDataHash()) * 2147483647);
            _debug.info(("Session ID: " + _local_1), VisualDebugMode.geek);
            return (_local_1);
        }

        private function _getDomainHash():Number
        {
            if ((((!(_config.domainName)) || (_config.domainName == "")) || (_config.domain.mode == DomainNameMode.none)))
            {
                _config.domainName = "";
                return (1);
            };
            _updateDomainName();
            if (_config.allowDomainHash)
            {
                return (Utils.generateHash(_config.domainName));
            };
            return (1);
        }

        public function setSessionTimeout(_arg_1:int):void
        {
            _config.sessionTimeout = _arg_1;
            _debug.info((("setSessionTimeout( " + _config.sessionTimeout) + " )"));
        }

        public function getAccount():String
        {
            _debug.info("getAccount()");
            return (_account);
        }

        public function link(targetUrl:String, useHash:Boolean=false):void
        {
            _initData();
            var out:String = _buffer.getLinkerUrl(targetUrl, useHash);
            var request:URLRequest = new URLRequest(out);
            _debug.info((("link( " + [targetUrl, useHash].join(",")) + " )"));
            try
            {
                navigateToURL(request, "_top");
            }
            catch(e:Error)
            {
                _debug.warning(("An error occured in link() msg: " + e.message));
            };
        }

        public function setRemoteServerMode():void
        {
            _config.serverMode = ServerOperationMode.remote;
            _debug.info("setRemoteServerMode()");
        }


    }
}//package com.google.analytics.v4

