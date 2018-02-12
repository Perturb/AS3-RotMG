// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.campaign.CampaignManager

package com.google.analytics.campaign
{
    import com.google.analytics.v4.Configuration;
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.core.Buffer;
    import com.google.analytics.utils.URL;
    import com.google.analytics.utils.Protocols;
    import com.google.analytics.debug.VisualDebugMode;
    import com.google.analytics.utils.Variables;
    import com.google.analytics.core.OrganicReferrer;

    public class CampaignManager 
    {

        public static const trackingDelimiter:String = "|";

        private var _config:Configuration;
        private var _domainHash:Number;
        private var _debug:DebugConfiguration;
        private var _timeStamp:Number;
        private var _referrer:String;
        private var _buffer:Buffer;

        public function CampaignManager(_arg_1:Configuration, _arg_2:DebugConfiguration, _arg_3:Buffer, _arg_4:Number, _arg_5:String, _arg_6:Number)
        {
            _config = _arg_1;
            _debug = _arg_2;
            _buffer = _arg_3;
            _domainHash = _arg_4;
            _referrer = _arg_5;
            _timeStamp = _arg_6;
        }

        public static function isInvalidReferrer(_arg_1:String):Boolean
        {
            var _local_2:URL;
            if ((((_arg_1 == "") || (_arg_1 == "-")) || (_arg_1 == "0")))
            {
                return (true);
            };
            if (_arg_1.indexOf("://") > -1)
            {
                _local_2 = new URL(_arg_1);
                if (((_local_2.protocol == Protocols.file) || (_local_2.protocol == Protocols.none)))
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function isFromGoogleCSE(_arg_1:String, _arg_2:Configuration):Boolean
        {
            var _local_3:URL = new URL(_arg_1);
            if (_local_3.hostName.indexOf(_arg_2.google) > -1)
            {
                if (_local_3.search.indexOf((_arg_2.googleSearchParam + "=")) > -1)
                {
                    if (_local_3.path == ("/" + _arg_2.googleCsePath))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }


        public function getCampaignInformation(_arg_1:String, _arg_2:Boolean):CampaignInfo
        {
            var _local_4:CampaignTracker;
            var _local_8:CampaignTracker;
            var _local_9:int;
            var _local_3:CampaignInfo = new CampaignInfo();
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:int;
            if (((_config.allowLinker) && (_buffer.isGenuine())))
            {
                if (!_buffer.hasUTMZ())
                {
                    return (_local_3);
                };
            };
            _local_4 = getTrackerFromSearchString(_arg_1);
            if (isValid(_local_4))
            {
                _local_6 = hasNoOverride(_arg_1);
                if (((_local_6) && (!(_buffer.hasUTMZ()))))
                {
                    return (_local_3);
                };
            };
            if (!isValid(_local_4))
            {
                _local_4 = getOrganicCampaign();
                if (((!(_buffer.hasUTMZ())) && (isIgnoredKeyword(_local_4))))
                {
                    return (_local_3);
                };
            };
            if (((!(isValid(_local_4))) && (_arg_2)))
            {
                _local_4 = getReferrerCampaign();
                if (((!(_buffer.hasUTMZ())) && (isIgnoredReferral(_local_4))))
                {
                    return (_local_3);
                };
            };
            if (!isValid(_local_4))
            {
                if (((!(_buffer.hasUTMZ())) && (_arg_2)))
                {
                    _local_4 = getDirectCampaign();
                };
            };
            if (!isValid(_local_4))
            {
                return (_local_3);
            };
            if (((_buffer.hasUTMZ()) && (!(_buffer.utmz.isEmpty()))))
            {
                _local_8 = new CampaignTracker();
                _local_8.fromTrackerString(_buffer.utmz.campaignTracking);
                _local_5 = (_local_8.toTrackerString() == _local_4.toTrackerString());
                _local_7 = _buffer.utmz.responseCount;
            };
            if (((!(_local_5)) || (_arg_2)))
            {
                _local_9 = _buffer.utma.sessionCount;
                _local_7++;
                if (_local_9 == 0)
                {
                    _local_9 = 1;
                };
                _buffer.utmz.domainHash = _domainHash;
                _buffer.utmz.campaignCreation = _timeStamp;
                _buffer.utmz.campaignSessions = _local_9;
                _buffer.utmz.responseCount = _local_7;
                _buffer.utmz.campaignTracking = _local_4.toTrackerString();
                _debug.info(_buffer.utmz.toString(), VisualDebugMode.geek);
                _local_3 = new CampaignInfo(false, true);
            }
            else
            {
                _local_3 = new CampaignInfo(false, false);
            };
            return (_local_3);
        }

        public function hasNoOverride(_arg_1:String):Boolean
        {
            var _local_2:CampaignKey = _config.campaignKey;
            if (_arg_1 == "")
            {
                return (false);
            };
            var _local_3:Variables = new Variables(_arg_1);
            var _local_4:* = "";
            if (_local_3.hasOwnProperty(_local_2.UCNO))
            {
                _local_4 = _local_3[_local_2.UCNO];
                switch (_local_4)
                {
                    case "1":
                        return (true);
                    case "":
                    case "0":
                    default:
                        return (false);
                };
            };
            return (false);
        }

        public function getTrackerFromSearchString(_arg_1:String):CampaignTracker
        {
            var _local_2:CampaignTracker = getOrganicCampaign();
            var _local_3:CampaignTracker = new CampaignTracker();
            var _local_4:CampaignKey = _config.campaignKey;
            if (_arg_1 == "")
            {
                return (_local_3);
            };
            var _local_5:Variables = new Variables(_arg_1);
            if (_local_5.hasOwnProperty(_local_4.UCID))
            {
                _local_3.id = _local_5[_local_4.UCID];
            };
            if (_local_5.hasOwnProperty(_local_4.UCSR))
            {
                _local_3.source = _local_5[_local_4.UCSR];
            };
            if (_local_5.hasOwnProperty(_local_4.UGCLID))
            {
                _local_3.clickId = _local_5[_local_4.UGCLID];
            };
            if (_local_5.hasOwnProperty(_local_4.UCCN))
            {
                _local_3.name = _local_5[_local_4.UCCN];
            }
            else
            {
                _local_3.name = "(not set)";
            };
            if (_local_5.hasOwnProperty(_local_4.UCMD))
            {
                _local_3.medium = _local_5[_local_4.UCMD];
            }
            else
            {
                _local_3.medium = "(not set)";
            };
            if (_local_5.hasOwnProperty(_local_4.UCTR))
            {
                _local_3.term = _local_5[_local_4.UCTR];
            }
            else
            {
                if (((_local_2) && (!(_local_2.term == ""))))
                {
                    _local_3.term = _local_2.term;
                };
            };
            if (_local_5.hasOwnProperty(_local_4.UCCT))
            {
                _local_3.content = _local_5[_local_4.UCCT];
            };
            return (_local_3);
        }

        public function getOrganicCampaign():CampaignTracker
        {
            var _local_1:CampaignTracker;
            var _local_4:Array;
            var _local_5:OrganicReferrer;
            var _local_6:String;
            if (((isInvalidReferrer(_referrer)) || (isFromGoogleCSE(_referrer, _config))))
            {
                return (_local_1);
            };
            var _local_2:URL = new URL(_referrer);
            var _local_3:* = "";
            if (_local_2.hostName != "")
            {
                if (_local_2.hostName.indexOf(".") > -1)
                {
                    _local_4 = _local_2.hostName.split(".");
                    switch (_local_4.length)
                    {
                        case 2:
                            _local_3 = _local_4[0];
                            break;
                        case 3:
                            _local_3 = _local_4[1];
                            break;
                    };
                };
            };
            if (_config.organic.match(_local_3))
            {
                _local_5 = _config.organic.getReferrerByName(_local_3);
                _local_6 = _config.organic.getKeywordValue(_local_5, _local_2.search);
                _local_1 = new CampaignTracker();
                _local_1.source = _local_5.engine;
                _local_1.name = "(organic)";
                _local_1.medium = "organic";
                _local_1.term = _local_6;
            };
            return (_local_1);
        }

        public function getDirectCampaign():CampaignTracker
        {
            var _local_1:CampaignTracker = new CampaignTracker();
            _local_1.source = "(direct)";
            _local_1.name = "(direct)";
            _local_1.medium = "(none)";
            return (_local_1);
        }

        public function isIgnoredKeyword(_arg_1:CampaignTracker):Boolean
        {
            if (((_arg_1) && (_arg_1.medium == "organic")))
            {
                return (_config.organic.isIgnoredKeyword(_arg_1.term));
            };
            return (false);
        }

        public function isIgnoredReferral(_arg_1:CampaignTracker):Boolean
        {
            if (((_arg_1) && (_arg_1.medium == "referral")))
            {
                return (_config.organic.isIgnoredReferral(_arg_1.source));
            };
            return (false);
        }

        public function isValid(_arg_1:CampaignTracker):Boolean
        {
            if (((_arg_1) && (_arg_1.isValid())))
            {
                return (true);
            };
            return (false);
        }

        public function getReferrerCampaign():CampaignTracker
        {
            var _local_1:CampaignTracker;
            if (((isInvalidReferrer(_referrer)) || (isFromGoogleCSE(_referrer, _config))))
            {
                return (_local_1);
            };
            var _local_2:URL = new URL(_referrer);
            var _local_3:String = _local_2.hostName;
            var _local_4:String = _local_2.path;
            if (_local_3.indexOf("www.") == 0)
            {
                _local_3 = _local_3.substr(4);
            };
            _local_1 = new CampaignTracker();
            _local_1.source = _local_3;
            _local_1.name = "(referral)";
            _local_1.medium = "referral";
            _local_1.content = _local_4;
            return (_local_1);
        }


    }
}//package com.google.analytics.campaign

