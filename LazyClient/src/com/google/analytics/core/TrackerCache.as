// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.TrackerCache

package com.google.analytics.core
{
    import com.google.analytics.v4.GoogleAnalyticsAPI;
    import flash.errors.IllegalOperationError;

    public class TrackerCache implements GoogleAnalyticsAPI 
    {

        public static var CACHE_THROW_ERROR:Boolean;

        public var tracker:GoogleAnalyticsAPI;
        private var _ar:Array;

        public function TrackerCache(_arg_1:GoogleAnalyticsAPI=null)
        {
            this.tracker = _arg_1;
            _ar = [];
        }

        public function size():uint
        {
            return (_ar.length);
        }

        public function flush():void
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            if (tracker == null)
            {
                return;
            };
            if (size() > 0)
            {
                _local_4 = _ar.length;
                while (_local_5 < _local_4)
                {
                    _local_1 = _ar.shift();
                    _local_2 = (_local_1.name as String);
                    _local_3 = (_local_1.args as Array);
                    if (((!(_local_2 == null)) && (_local_2 in tracker)))
                    {
                        (tracker[_local_2] as Function).apply(tracker, _local_3);
                    };
                    _local_5++;
                };
            };
        }

        public function enqueue(_arg_1:String, ... _args):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _ar.push({
                "name":_arg_1,
                "args":_args
            });
            return (true);
        }

        public function link(_arg_1:String, _arg_2:Boolean=false):void
        {
            enqueue("link", _arg_1, _arg_2);
        }

        public function addOrganic(_arg_1:String, _arg_2:String):void
        {
            enqueue("addOrganic", _arg_1, _arg_2);
        }

        public function setAllowLinker(_arg_1:Boolean):void
        {
            enqueue("setAllowLinker", _arg_1);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:Number=NaN):Boolean
        {
            enqueue("trackEvent", _arg_1, _arg_2, _arg_3, _arg_4);
            return (true);
        }

        public function getLinkerUrl(_arg_1:String="", _arg_2:Boolean=false):String
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getLinkerUrl' method for the moment."));
            };
            return ("");
        }

        public function getClientInfo():Boolean
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getClientInfo' method for the moment."));
            };
            return (false);
        }

        public function trackTrans():void
        {
            enqueue("trackTrans");
        }

        public function trackPageview(_arg_1:String=""):void
        {
            enqueue("trackPageview", _arg_1);
        }

        public function setClientInfo(_arg_1:Boolean):void
        {
            enqueue("setClientInfo", _arg_1);
        }

        public function linkByPost(_arg_1:Object, _arg_2:Boolean=false):void
        {
            enqueue("linkByPost", _arg_1, _arg_2);
        }

        public function setCookieTimeout(_arg_1:int):void
        {
            enqueue("setCookieTimeout", _arg_1);
        }

        public function isEmpty():Boolean
        {
            return (_ar.length == 0);
        }

        public function getDetectTitle():Boolean
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getDetectTitle' method for the moment."));
            };
            return (false);
        }

        public function resetSession():void
        {
            enqueue("resetSession");
        }

        public function setDetectFlash(_arg_1:Boolean):void
        {
            enqueue("setDetectFlash", _arg_1);
        }

        public function clear():void
        {
            _ar = [];
        }

        public function setCampNameKey(_arg_1:String):void
        {
            enqueue("setCampNameKey", _arg_1);
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:int):void
        {
            enqueue("addItem", _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public function createEventTracker(_arg_1:String):EventTracker
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'createEventTracker' method for the moment."));
            };
            return (null);
        }

        public function clearIgnoredOrganic():void
        {
            enqueue("clearIgnoredOrganic");
        }

        public function setVar(_arg_1:String):void
        {
            enqueue("setVar", _arg_1);
        }

        public function setDomainName(_arg_1:String):void
        {
            enqueue("setDomainName", _arg_1);
        }

        public function setCampSourceKey(_arg_1:String):void
        {
            enqueue("setCampSourceKey", _arg_1);
        }

        public function addTrans(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:String, _arg_7:String, _arg_8:String):void
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'addTrans' method for the moment."));
            };
        }

        public function setCampContentKey(_arg_1:String):void
        {
            enqueue("setCampContentKey", _arg_1);
        }

        public function setLocalServerMode():void
        {
            enqueue("setLocalServerMode");
        }

        public function getLocalGifPath():String
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getLocalGifPath' method for the moment."));
            };
            return ("");
        }

        public function setAllowAnchor(_arg_1:Boolean):void
        {
            enqueue("setAllowAnchor", _arg_1);
        }

        public function clearIgnoredRef():void
        {
            enqueue("clearIgnoredRef");
        }

        public function setLocalGifPath(_arg_1:String):void
        {
            enqueue("setLocalGifPath", _arg_1);
        }

        public function getVersion():String
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getVersion' method for the moment."));
            };
            return ("");
        }

        public function setCookiePath(_arg_1:String):void
        {
            enqueue("setCookiePath", _arg_1);
        }

        public function setSampleRate(_arg_1:Number):void
        {
            enqueue("setSampleRate", _arg_1);
        }

        public function setDetectTitle(_arg_1:Boolean):void
        {
            enqueue("setDetectTitle", _arg_1);
        }

        public function setAllowHash(_arg_1:Boolean):void
        {
            enqueue("setAllowHash", _arg_1);
        }

        public function addIgnoredOrganic(_arg_1:String):void
        {
            enqueue("addIgnoredOrganic", _arg_1);
        }

        public function setCampNOKey(_arg_1:String):void
        {
            enqueue("setCampNOKey", _arg_1);
        }

        public function getServiceMode():ServerOperationMode
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getServiceMode' method for the moment."));
            };
            return (null);
        }

        public function setLocalRemoteServerMode():void
        {
            enqueue("setLocalRemoteServerMode");
        }

        public function cookiePathCopy(_arg_1:String):void
        {
            enqueue("cookiePathCopy", _arg_1);
        }

        public function getDetectFlash():Boolean
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getDetectFlash' method for the moment."));
            };
            return (false);
        }

        public function setCampaignTrack(_arg_1:Boolean):void
        {
            enqueue("setCampaignTrack", _arg_1);
        }

        public function clearOrganic():void
        {
            enqueue("clearOrganic");
        }

        public function setCampTermKey(_arg_1:String):void
        {
            enqueue("setCampTermKey", _arg_1);
        }

        public function addIgnoredRef(_arg_1:String):void
        {
            enqueue("addIgnoredRef", _arg_1);
        }

        public function setCampMediumKey(_arg_1:String):void
        {
            enqueue("setCampMediumKey", _arg_1);
        }

        public function setSessionTimeout(_arg_1:int):void
        {
            enqueue("setSessionTimeout", _arg_1);
        }

        public function setRemoteServerMode():void
        {
            enqueue("setRemoteServerMode");
        }

        public function element():*
        {
            return (_ar[0]);
        }

        public function getAccount():String
        {
            if (CACHE_THROW_ERROR)
            {
                throw (new IllegalOperationError("The tracker is not ready and you can use the 'getAccount' method for the moment."));
            };
            return ("");
        }


    }
}//package com.google.analytics.core

