// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.v4.Bridge

package com.google.analytics.v4
{
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.external.JavascriptProxy;
    import com.google.analytics.debug.VisualDebugMode;
    import com.google.analytics.core.Utils;
    import com.google.analytics.core.EventTracker;
    import com.google.analytics.core.ServerOperationMode;

    public class Bridge implements GoogleAnalyticsAPI 
    {

        private static var _checkGAJS_js:XML = <script>
            <![CDATA[
                function()
                {
                    if( _gat && _gat._getTracker )
                    {
                        return true;
                    }
                    return false;
                }
            ]]>
        </script>
        ;
        private static var _checkValidTrackingObject_js:XML = <script>
            <![CDATA[
                function(acct)
                {
                    if( _GATracker[acct] && (_GATracker[acct]._getAccount) )
                    {
                        return true ;
                    }
                    else
                    {
                        return false;
                    }
                }
            ]]>
        </script>
        ;
        private static var _createTrackingObject_js:XML = <script>
            <![CDATA[
                function( acct )
                {
                    _GATracker[acct] = _gat._getTracker(acct);
                }
            ]]>
        </script>
        ;
        private static var _injectTrackingObject_js:XML = <script>
            <![CDATA[
                function()
                {
                    try 
                    {
                        _GATracker
                    }
                    catch(e) 
                    {
                        _GATracker = {};
                    }
                }
            ]]>
        </script>
        ;
        private static var _linkTrackingObject_js:XML = <script>
            <![CDATA[
                function( container , target )
                {
                    var targets ;
                    var name ;
                    if( target.indexOf(".") > 0 )
                    {
                        targets = target.split(".");
                        name    = targets.pop();
                    }
                    else
                    {
                        targets = [];
                        name    = target;
                    }
                    var ref   = window;
                    var depth = targets.length;
                    for( var j = 0 ; j < depth ; j++ )
                    {
                        ref = ref[ targets[j] ] ;
                    }
                    window[container][target] = ref[name] ;
                }
            ]]>
        </script>
        ;

        private var _debug:DebugConfiguration;
        private var _proxy:JavascriptProxy;
        private var _jsContainer:String = "_GATracker";
        private var _hasGATracker:Boolean = false;
        private var _account:String;

        public function Bridge(_arg_1:String, _arg_2:DebugConfiguration, _arg_3:JavascriptProxy)
        {
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            super();
            _account = _arg_1;
            _debug = _arg_2;
            _proxy = _arg_3;
            if (!_checkGAJS())
            {
                _local_4 = "";
                _local_4 = (_local_4 + "ga.js not found, be sure to check if\n");
                _local_4 = (_local_4 + '<script src="http://www.google-analytics.com/ga.js"></script>\n');
                _local_4 = (_local_4 + "is included in the HTML.");
                _debug.warning(_local_4);
                throw (new Error(_local_4));
            };
            if (!_hasGATracker)
            {
                if (((_debug.javascript) && (_debug.verbose)))
                {
                    _local_5 = "";
                    _local_5 = (_local_5 + "The Google Analytics tracking code was not found on the container page\n");
                    _local_5 = (_local_5 + "we create it");
                    _debug.info(_local_5, VisualDebugMode.advanced);
                };
                _injectTrackingObject();
            };
            if (Utils.validateAccount(_arg_1))
            {
                _createTrackingObject(_arg_1);
            }
            else
            {
                if (_checkTrackingObject(_arg_1))
                {
                    _linkTrackingObject(_arg_1);
                }
                else
                {
                    _local_6 = "";
                    _local_6 = (_local_6 + (('JS Object "' + _arg_1) + "\" doesn't exist in DOM\n"));
                    _local_6 = (_local_6 + "Bridge object not created.");
                    _debug.warning(_local_6);
                    throw (new Error(_local_6));
                };
            };
        }

        public function link(_arg_1:String, _arg_2:Boolean=false):void
        {
            _debug.info((((("link( " + _arg_1) + ", ") + _arg_2) + " )"));
            _call("_link", _arg_1, _arg_2);
        }

        public function addOrganic(_arg_1:String, _arg_2:String):void
        {
            _debug.info((("addOrganic( " + [_arg_1, _arg_2].join(", ")) + " )"));
            _call("_addOrganic", _arg_1);
        }

        public function setAllowLinker(_arg_1:Boolean):void
        {
            _debug.info((("setAllowLinker( " + _arg_1) + " )"));
            _call("_setAllowLinker", _arg_1);
        }

        public function getLinkerUrl(_arg_1:String="", _arg_2:Boolean=false):String
        {
            _debug.info((((("getLinkerUrl(" + _arg_1) + ", ") + _arg_2) + ")"));
            return (_call("_getLinkerUrl", _arg_1, _arg_2));
        }

        private function _linkTrackingObject(_arg_1:String):void
        {
            _proxy.call(_linkTrackingObject_js, _jsContainer, _arg_1);
        }

        public function setClientInfo(_arg_1:Boolean):void
        {
            _debug.info((("setClientInfo( " + _arg_1) + " )"));
            _call("_setClientInfo", _arg_1);
        }

        public function trackTrans():void
        {
            _debug.info("trackTrans()");
            _call("_trackTrans");
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:Number=NaN):Boolean
        {
            var _local_5:int = 2;
            if (((_arg_3) && (!(_arg_3 == ""))))
            {
                _local_5 = 3;
            };
            if (((_local_5 == 3) && (!(isNaN(_arg_4)))))
            {
                _local_5 = 4;
            };
            switch (_local_5)
            {
                case 4:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2, _arg_3, _arg_4].join(", ")) + " )"));
                    return (_call("_trackEvent", _arg_1, _arg_2, _arg_3, _arg_4));
                case 3:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2, _arg_3].join(", ")) + " )"));
                    return (_call("_trackEvent", _arg_1, _arg_2, _arg_3));
                case 2:
                default:
                    _debug.info((("trackEvent( " + [_arg_1, _arg_2].join(", ")) + " )"));
                    return (_call("_trackEvent", _arg_1, _arg_2));
            };
        }

        public function setCookieTimeout(_arg_1:int):void
        {
            _debug.info((("setCookieTimeout( " + _arg_1) + " )"));
            _call("_setCookieTimeout", _arg_1);
        }

        public function trackPageview(_arg_1:String=""):void
        {
            _debug.info((("trackPageview( " + _arg_1) + " )"));
            _call("_trackPageview", _arg_1);
        }

        private function _checkValidTrackingObject(_arg_1:String):Boolean
        {
            return (_proxy.call(_checkValidTrackingObject_js, _arg_1));
        }

        private function _checkGAJS():Boolean
        {
            return (_proxy.call(_checkGAJS_js));
        }

        public function linkByPost(_arg_1:Object, _arg_2:Boolean=false):void
        {
            _debug.warning((((("linkByPost( " + _arg_1) + ", ") + _arg_2) + " ) not implemented"));
        }

        public function getClientInfo():Boolean
        {
            _debug.info("getClientInfo()");
            return (_call("_getClientInfo"));
        }

        private function _call(_arg_1:String, ... _args):*
        {
            _args.unshift(((((("window." + _jsContainer) + '["') + _account) + '"].') + _arg_1));
            return (_proxy.call.apply(_proxy, _args));
        }

        public function hasGAJS():Boolean
        {
            return (_checkGAJS());
        }

        private function _checkTrackingObject(_arg_1:String):Boolean
        {
            var _local_2:Boolean = _proxy.hasProperty(_arg_1);
            var _local_3:Boolean = _proxy.hasProperty((_arg_1 + "._getAccount"));
            return ((_local_2) && (_local_3));
        }

        public function resetSession():void
        {
            _debug.warning("resetSession() not implemented");
        }

        public function getDetectTitle():Boolean
        {
            _debug.info("getDetectTitle()");
            return (_call("_getDetectTitle"));
        }

        public function setCampNameKey(_arg_1:String):void
        {
            _debug.info((("setCampNameKey( " + _arg_1) + " )"));
            _call("_setCampNameKey", _arg_1);
        }

        public function setDetectFlash(_arg_1:Boolean):void
        {
            _debug.info((("setDetectFlash( " + _arg_1) + " )"));
            _call("_setDetectFlash", _arg_1);
        }

        public function createEventTracker(_arg_1:String):EventTracker
        {
            _debug.info((("createEventTracker( " + _arg_1) + " )"));
            return (new EventTracker(_arg_1, this));
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:int):void
        {
            _debug.info((("addItem( " + [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6].join(", ")) + " )"));
            _call("_addItem", _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public function clearIgnoredOrganic():void
        {
            _debug.info("clearIgnoredOrganic()");
            _call("_clearIgnoreOrganic");
        }

        public function setVar(_arg_1:String):void
        {
            _debug.info((("setVar( " + _arg_1) + " )"));
            _call("_setVar", _arg_1);
        }

        public function setDomainName(_arg_1:String):void
        {
            _debug.info((("setDomainName( " + _arg_1) + " )"));
            _call("_setDomainName", _arg_1);
        }

        public function hasTrackingAccount(_arg_1:String):Boolean
        {
            if (Utils.validateAccount(_arg_1))
            {
                return (_checkValidTrackingObject(_arg_1));
            };
            return (_checkTrackingObject(_arg_1));
        }

        public function setCampSourceKey(_arg_1:String):void
        {
            _debug.info((("setCampSourceKey( " + _arg_1) + " )"));
            _call("_setCampSourceKey", _arg_1);
        }

        public function addTrans(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:String, _arg_7:String, _arg_8:String):void
        {
            _debug.info((("addTrans( " + [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8].join(", ")) + " )"));
            _call("_addTrans", _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
        }

        public function setCampContentKey(_arg_1:String):void
        {
            _debug.info((("setCampContentKey( " + _arg_1) + " )"));
            _call("_setCampContentKey", _arg_1);
        }

        public function setLocalServerMode():void
        {
            _debug.info("setLocalServerMode()");
            _call("_setLocalServerMode");
        }

        public function getLocalGifPath():String
        {
            _debug.info("getLocalGifPath()");
            return (_call("_getLocalGifPath"));
        }

        public function clearIgnoredRef():void
        {
            _debug.info("clearIgnoredRef()");
            _call("_clearIgnoreRef");
        }

        public function setAllowAnchor(_arg_1:Boolean):void
        {
            _debug.info((("setAllowAnchor( " + _arg_1) + " )"));
            _call("_setAllowAnchor", _arg_1);
        }

        public function setLocalGifPath(_arg_1:String):void
        {
            _debug.info((("setLocalGifPath( " + _arg_1) + " )"));
            _call("_setLocalGifPath", _arg_1);
        }

        public function getVersion():String
        {
            _debug.info("getVersion()");
            return (_call("_getVersion"));
        }

        private function _injectTrackingObject():void
        {
            _proxy.executeBlock(_injectTrackingObject_js);
            _hasGATracker = true;
        }

        public function setCookiePath(_arg_1:String):void
        {
            _debug.info((("setCookiePath( " + _arg_1) + " )"));
            _call("_setCookiePath", _arg_1);
        }

        public function setSampleRate(_arg_1:Number):void
        {
            _debug.info((("setSampleRate( " + _arg_1) + " )"));
            _call("_setSampleRate", _arg_1);
        }

        public function setAllowHash(_arg_1:Boolean):void
        {
            _debug.info((("setAllowHash( " + _arg_1) + " )"));
            _call("_setAllowHash", _arg_1);
        }

        public function addIgnoredOrganic(_arg_1:String):void
        {
            _debug.info((("addIgnoredOrganic( " + _arg_1) + " )"));
            _call("_addIgnoredOrganic", _arg_1);
        }

        public function setCampNOKey(_arg_1:String):void
        {
            _debug.info((("setCampNOKey( " + _arg_1) + " )"));
            _call("_setCampNOKey", _arg_1);
        }

        public function cookiePathCopy(_arg_1:String):void
        {
            _debug.info((("cookiePathCopy( " + _arg_1) + " )"));
            _call("_cookiePathCopy", _arg_1);
        }

        public function setLocalRemoteServerMode():void
        {
            _debug.info("setLocalRemoteServerMode()");
            _call("_setLocalRemoteServerMode");
        }

        public function getServiceMode():ServerOperationMode
        {
            _debug.info("getServiceMode()");
            return (_call("_getServiceMode"));
        }

        public function setDetectTitle(_arg_1:Boolean):void
        {
            _debug.info((("setDetectTitle( " + _arg_1) + " )"));
            _call("_setDetectTitle", _arg_1);
        }

        private function _createTrackingObject(_arg_1:String):void
        {
            _proxy.call(_createTrackingObject_js, _arg_1);
        }

        public function setCampaignTrack(_arg_1:Boolean):void
        {
            _debug.info((("setCampaignTrack( " + _arg_1) + " )"));
            _call("_setCampaignTrack", _arg_1);
        }

        public function clearOrganic():void
        {
            _debug.info("clearOrganic()");
            _call("_clearOrganic");
        }

        public function setCampTermKey(_arg_1:String):void
        {
            _debug.info((("setCampTermKey( " + _arg_1) + " )"));
            _call("_setCampTermKey", _arg_1);
        }

        public function getDetectFlash():Boolean
        {
            _debug.info("getDetectFlash()");
            return (_call("_getDetectFlash"));
        }

        public function setCampMediumKey(_arg_1:String):void
        {
            _debug.info((("setCampMediumKey( " + _arg_1) + " )"));
            _call("_setCampMediumKey", _arg_1);
        }

        public function addIgnoredRef(_arg_1:String):void
        {
            _debug.info((("addIgnoredRef( " + _arg_1) + " )"));
            _call("_addIgnoredRef", _arg_1);
        }

        public function setSessionTimeout(_arg_1:int):void
        {
            _debug.info((("setSessionTimeout( " + _arg_1) + " )"));
            _call("_setSessionTimeout", _arg_1);
        }

        public function setRemoteServerMode():void
        {
            _debug.info("setRemoteServerMode()");
            _call("_setRemoteServerMode");
        }

        public function getAccount():String
        {
            _debug.info("getAccount()");
            return (_call("_getAccount"));
        }


    }
}//package com.google.analytics.v4

