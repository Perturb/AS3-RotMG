// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.GATracker

package com.google.analytics
{
    import com.google.analytics.utils.Version;
    import com.google.analytics.external.AdSenseGlobals;
    import com.google.analytics.utils.Environment;
    import com.google.analytics.core.IdleTimer;
    import com.google.analytics.debug.DebugConfiguration;
    import com.google.analytics.core.Buffer;
    import com.google.analytics.v4.Configuration;
    import flash.display.DisplayObject;
    import com.google.analytics.external.JavascriptProxy;
    import com.google.analytics.external.HTMLDOM;
    import flash.events.EventDispatcher;
    import com.google.analytics.core.GIFRequest;
    import com.google.analytics.core.Ecommerce;
    import com.google.analytics.v4.GoogleAnalyticsAPI;
    import com.google.analytics.core.TrackerCache;
    import flash.events.Event;
    import com.google.analytics.v4.Bridge;
    import com.google.analytics.core.EventTracker;
    import com.google.analytics.debug.Layout;
    import com.google.analytics.core.TrackerMode;
    import com.google.analytics.events.AnalyticsEvent;
    import com.google.analytics.core.ga_internal;
    import com.google.analytics.v4.Tracker;
    import com.google.analytics.core.ServerOperationMode;

    use namespace ga_internal;

    public class GATracker implements AnalyticsTracker 
    {

        public static var autobuild:Boolean = true;
        public static var version:Version = API.version;

        private var _adSense:AdSenseGlobals;
        private var _env:Environment;
        private var _visualDebug:Boolean;
        private var _idleTimer:IdleTimer;
        private var _debug:DebugConfiguration;
        private var _buffer:Buffer;
        private var _config:Configuration;
        private var _mode:String;
        private var _display:DisplayObject;
        private var _jsproxy:JavascriptProxy;
        private var _dom:HTMLDOM;
        private var _eventDispatcher:EventDispatcher;
        private var _ready:Boolean = false;
        private var _gifRequest:GIFRequest;
        private var _ecom:Ecommerce;
        private var _account:String;
        private var _tracker:GoogleAnalyticsAPI;

        public function GATracker(_arg_1:DisplayObject, _arg_2:String, _arg_3:String="AS3", _arg_4:Boolean=false, _arg_5:Configuration=null, _arg_6:DebugConfiguration=null)
        {
            _display = _arg_1;
            _eventDispatcher = new EventDispatcher(this);
            _tracker = new TrackerCache();
            this.account = _arg_2;
            this.mode = _arg_3;
            this.visualDebug = _arg_4;
            if (!_arg_6)
            {
                this.debug = new DebugConfiguration();
            };
            if (!_arg_5)
            {
                this.config = new Configuration(_arg_6);
            }
            else
            {
                this.config = _arg_5;
            };
            if (autobuild)
            {
                _factory();
            };
        }

        public function link(_arg_1:String, _arg_2:Boolean=false):void
        {
            _tracker.link(_arg_1, _arg_2);
        }

        public function addOrganic(_arg_1:String, _arg_2:String):void
        {
            _tracker.addOrganic(_arg_1, _arg_2);
        }

        public function setAllowLinker(_arg_1:Boolean):void
        {
            _tracker.setAllowLinker(_arg_1);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:Number=NaN):Boolean
        {
            return (_tracker.trackEvent(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function getLinkerUrl(_arg_1:String="", _arg_2:Boolean=false):String
        {
            return (_tracker.getLinkerUrl(_arg_1, _arg_2));
        }

        public function setCookieTimeout(_arg_1:int):void
        {
            _tracker.setCookieTimeout(_arg_1);
        }

        public function trackTrans():void
        {
            _tracker.trackTrans();
        }

        public function getClientInfo():Boolean
        {
            return (_tracker.getClientInfo());
        }

        public function trackPageview(_arg_1:String=""):void
        {
            _tracker.trackPageview(_arg_1);
        }

        public function setClientInfo(_arg_1:Boolean):void
        {
            _tracker.setClientInfo(_arg_1);
        }

        public function get account():String
        {
            return (_account);
        }

        public function linkByPost(_arg_1:Object, _arg_2:Boolean=false):void
        {
            _tracker.linkByPost(_arg_1, _arg_2);
        }

        public function getDetectTitle():Boolean
        {
            return (_tracker.getDetectTitle());
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_eventDispatcher.dispatchEvent(_arg_1));
        }

        public function get config():Configuration
        {
            return (_config);
        }

        public function set mode(_arg_1:String):void
        {
            _mode = _arg_1;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _eventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function setDetectFlash(_arg_1:Boolean):void
        {
            _tracker.setDetectFlash(_arg_1);
        }

        public function resetSession():void
        {
            _tracker.resetSession();
        }

        public function setCampNameKey(_arg_1:String):void
        {
            _tracker.setCampNameKey(_arg_1);
        }

        public function get debug():DebugConfiguration
        {
            return (_debug);
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:int):void
        {
            _tracker.addItem(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        private function _bridgeFactory():GoogleAnalyticsAPI
        {
            debug.info(((("GATracker (Bridge) v" + version) + "\naccount: ") + account));
            return (new Bridge(account, _debug, _jsproxy));
        }

        public function clearIgnoredOrganic():void
        {
            _tracker.clearIgnoredOrganic();
        }

        public function set account(_arg_1:String):void
        {
            _account = _arg_1;
        }

        public function setVar(_arg_1:String):void
        {
            _tracker.setVar(_arg_1);
        }

        public function build():void
        {
            if (!isReady())
            {
                _factory();
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _eventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function setDomainName(_arg_1:String):void
        {
            _tracker.setDomainName(_arg_1);
        }

        public function createEventTracker(_arg_1:String):EventTracker
        {
            return (_tracker.createEventTracker(_arg_1));
        }

        public function setCampSourceKey(_arg_1:String):void
        {
            _tracker.setCampSourceKey(_arg_1);
        }

        public function set config(_arg_1:Configuration):void
        {
            _config = _arg_1;
        }

        public function addTrans(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:String, _arg_7:String, _arg_8:String):void
        {
            _tracker.addTrans(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
        }

        public function setCampContentKey(_arg_1:String):void
        {
            _tracker.setCampContentKey(_arg_1);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_eventDispatcher.willTrigger(_arg_1));
        }

        public function setLocalServerMode():void
        {
            _tracker.setLocalServerMode();
        }

        public function isReady():Boolean
        {
            return (_ready);
        }

        public function getLocalGifPath():String
        {
            return (_tracker.getLocalGifPath());
        }

        public function setAllowAnchor(_arg_1:Boolean):void
        {
            _tracker.setAllowAnchor(_arg_1);
        }

        public function clearIgnoredRef():void
        {
            _tracker.clearIgnoredRef();
        }

        public function get mode():String
        {
            return (_mode);
        }

        public function set debug(_arg_1:DebugConfiguration):void
        {
            _debug = _arg_1;
        }

        public function setLocalGifPath(_arg_1:String):void
        {
            _tracker.setLocalGifPath(_arg_1);
        }

        public function getVersion():String
        {
            return (_tracker.getVersion());
        }

        public function setSampleRate(_arg_1:Number):void
        {
            _tracker.setSampleRate(_arg_1);
        }

        public function setCookiePath(_arg_1:String):void
        {
            _tracker.setCookiePath(_arg_1);
        }

        public function setAllowHash(_arg_1:Boolean):void
        {
            _tracker.setAllowHash(_arg_1);
        }

        public function addIgnoredOrganic(_arg_1:String):void
        {
            _tracker.addIgnoredOrganic(_arg_1);
        }

        public function setLocalRemoteServerMode():void
        {
            _tracker.setLocalRemoteServerMode();
        }

        public function cookiePathCopy(_arg_1:String):void
        {
            _tracker.cookiePathCopy(_arg_1);
        }

        private function _factory():void
        {
            var _local_1:GoogleAnalyticsAPI;
            _jsproxy = new JavascriptProxy(debug);
            if (visualDebug)
            {
                debug.layout = new Layout(debug, _display);
                debug.active = visualDebug;
            };
            var _local_2:TrackerCache = (_tracker as TrackerCache);
            switch (mode)
            {
                case TrackerMode.BRIDGE:
                    _local_1 = _bridgeFactory();
                    break;
                case TrackerMode.AS3:
                default:
                    _local_1 = _trackerFactory();
            };
            if (!_local_2.isEmpty())
            {
                _local_2.tracker = _local_1;
                _local_2.flush();
            };
            _tracker = _local_1;
            _ready = true;
            dispatchEvent(new AnalyticsEvent(AnalyticsEvent.READY, this));
        }

        public function setCampTermKey(_arg_1:String):void
        {
            _tracker.setCampTermKey(_arg_1);
        }

        private function _trackerFactory():GoogleAnalyticsAPI
        {
            debug.info(((("GATracker (AS3) v" + version) + "\naccount: ") + account));
            _adSense = new AdSenseGlobals(debug);
            _dom = new HTMLDOM(debug);
            _dom.cacheProperties();
            _env = new Environment("", "", "", debug, _dom);
            _buffer = new Buffer(config, debug, false);
            _gifRequest = new GIFRequest(config, debug, _buffer, _env);
            _idleTimer = new IdleTimer(config, debug, _display, _buffer);
            _ecom = new Ecommerce(_debug);
            _env.ga_internal::url = _display.stage.loaderInfo.url;
            return (new Tracker(account, config, debug, _env, _buffer, _gifRequest, _adSense, _ecom));
        }

        public function setCampNOKey(_arg_1:String):void
        {
            _tracker.setCampNOKey(_arg_1);
        }

        public function setDetectTitle(_arg_1:Boolean):void
        {
            _tracker.setDetectTitle(_arg_1);
        }

        public function clearOrganic():void
        {
            _tracker.clearOrganic();
        }

        public function setCampaignTrack(_arg_1:Boolean):void
        {
            _tracker.setCampaignTrack(_arg_1);
        }

        public function addIgnoredRef(_arg_1:String):void
        {
            _tracker.addIgnoredRef(_arg_1);
        }

        public function getServiceMode():ServerOperationMode
        {
            return (_tracker.getServiceMode());
        }

        public function set visualDebug(_arg_1:Boolean):void
        {
            _visualDebug = _arg_1;
        }

        public function setCampMediumKey(_arg_1:String):void
        {
            _tracker.setCampMediumKey(_arg_1);
        }

        public function getDetectFlash():Boolean
        {
            return (_tracker.getDetectFlash());
        }

        public function get visualDebug():Boolean
        {
            return (_visualDebug);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_eventDispatcher.hasEventListener(_arg_1));
        }

        public function getAccount():String
        {
            return (_tracker.getAccount());
        }

        public function setSessionTimeout(_arg_1:int):void
        {
            _tracker.setSessionTimeout(_arg_1);
        }

        public function setRemoteServerMode():void
        {
            _tracker.setRemoteServerMode();
        }


    }
}//package com.google.analytics
import com.google.analytics.core.ServerOperationMode;

ServerOperationMode;

