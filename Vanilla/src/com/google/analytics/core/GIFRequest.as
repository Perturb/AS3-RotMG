// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.GIFRequest

package com.google.analytics.core
{
    import com.google.analytics.utils.Environment;
    import com.google.analytics.debug.DebugConfiguration;
    import flash.net.URLRequest;
    import com.google.analytics.v4.Configuration;
    import com.google.analytics.debug.VisualDebugMode;
    import flash.events.IOErrorEvent;
    import com.google.analytics.utils.Variables;
    import com.google.analytics.utils.Protocols;
    import flash.events.SecurityErrorEvent;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.events.Event;

    public class GIFRequest 
    {

        private var _info:Environment;
        private var _count:int;
        private var _utmac:String;
        private var _alertcount:int;
        private var _debug:DebugConfiguration;
        private var _lastRequest:URLRequest;
        private var _buffer:Buffer;
        private var _config:Configuration;
        private var _requests:Array;

        public function GIFRequest(_arg_1:Configuration, _arg_2:DebugConfiguration, _arg_3:Buffer, _arg_4:Environment)
        {
            _config = _arg_1;
            _debug = _arg_2;
            _buffer = _arg_3;
            _info = _arg_4;
            _count = 0;
            _alertcount = 0;
            _requests = [];
        }

        public function get utmn():String
        {
            return (Utils.generate32bitRandom() as String);
        }

        public function onIOError(_arg_1:IOErrorEvent):void
        {
            var _local_2:String = _lastRequest.url;
            var _local_3:String = String((_requests.length - 1));
            var _local_4:* = (("Gif Request #" + _local_3) + " failed");
            if (_debug.GIFRequests)
            {
                if (!_debug.verbose)
                {
                    if (_local_2.indexOf("?") > -1)
                    {
                        _local_2 = _local_2.split("?")[0];
                    };
                    _local_2 = _shortenURL(_local_2);
                };
                if (int(_debug.mode) > int(VisualDebugMode.basic))
                {
                    _local_4 = (_local_4 + ((' "' + _local_2) + '" does not exists or is unreachable'));
                };
                _debug.failure(_local_4);
            }
            else
            {
                _debug.warning(_local_4);
            };
            _removeListeners(_arg_1.target);
        }

        public function send(_arg_1:String, _arg_2:Variables=null, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_5:String;
            var _local_6:URLRequest;
            var _local_7:URLRequest;
            _utmac = _arg_1;
            if (!_arg_2)
            {
                _arg_2 = new Variables();
            };
            _arg_2.URIencode = false;
            _arg_2.pre = ["utmwv", "utmn", "utmhn", "utmt", "utme", "utmcs", "utmsr", "utmsc", "utmul", "utmje", "utmfl", "utmdt", "utmhid", "utmr", "utmp"];
            _arg_2.post = ["utmcc"];
            if (_debug.verbose)
            {
                _debug.info(((("tracking: " + _buffer.utmb.trackCount) + "/") + _config.trackingLimitPerSession), VisualDebugMode.geek);
            };
            if (((_buffer.utmb.trackCount < _config.trackingLimitPerSession) || (_arg_3)))
            {
                if (_arg_4)
                {
                    updateToken();
                };
                if ((((_arg_3) || (!(_arg_4))) || (_buffer.utmb.token >= 1)))
                {
                    if (((!(_arg_3)) && (_arg_4)))
                    {
                        _buffer.utmb.token--;
                    };
                    _buffer.utmb.trackCount = (_buffer.utmb.trackCount + 1);
                    if (_debug.verbose)
                    {
                        _debug.info(_buffer.utmb.toString(), VisualDebugMode.geek);
                    };
                    _arg_2.utmwv = utmwv;
                    _arg_2.utmn = Utils.generate32bitRandom();
                    if (_info.domainName != "")
                    {
                        _arg_2.utmhn = _info.domainName;
                    };
                    if (_config.sampleRate < 1)
                    {
                        _arg_2.utmsp = (_config.sampleRate * 100);
                    };
                    if (((_config.serverMode == ServerOperationMode.local) || (_config.serverMode == ServerOperationMode.both)))
                    {
                        _local_5 = _info.locationSWFPath;
                        if (_local_5.lastIndexOf("/") > 0)
                        {
                            _local_5 = _local_5.substring(0, _local_5.lastIndexOf("/"));
                        };
                        _local_6 = new URLRequest();
                        if (_config.localGIFpath.indexOf("http") == 0)
                        {
                            _local_6.url = _config.localGIFpath;
                        }
                        else
                        {
                            _local_6.url = (_local_5 + _config.localGIFpath);
                        };
                        _local_6.url = (_local_6.url + ("?" + _arg_2.toString()));
                        if (((_debug.active) && (_debug.GIFRequests)))
                        {
                            _debugSend(_local_6);
                        }
                        else
                        {
                            sendRequest(_local_6);
                        };
                    };
                    if (((_config.serverMode == ServerOperationMode.remote) || (_config.serverMode == ServerOperationMode.both)))
                    {
                        _local_7 = new URLRequest();
                        if (_info.protocol == Protocols.HTTPS)
                        {
                            _local_7.url = _config.secureRemoteGIFpath;
                        }
                        else
                        {
                            if (_info.protocol == Protocols.HTTP)
                            {
                                _local_7.url = _config.remoteGIFpath;
                            }
                            else
                            {
                                _local_7.url = _config.remoteGIFpath;
                            };
                        };
                        _arg_2.utmac = utmac;
                        _arg_2.utmcc = encodeURIComponent(utmcc);
                        _local_7.url = (_local_7.url + ("?" + _arg_2.toString()));
                        if (((_debug.active) && (_debug.GIFRequests)))
                        {
                            _debugSend(_local_7);
                        }
                        else
                        {
                            sendRequest(_local_7);
                        };
                    };
                };
            };
        }

        public function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            if (_debug.GIFRequests)
            {
                _debug.failure(_arg_1.text);
            };
        }

        public function get utmsp():String
        {
            return ((_config.sampleRate * 100) as String);
        }

        public function get utmcc():String
        {
            var _local_1:Array = [];
            if (_buffer.hasUTMA())
            {
                _local_1.push((_buffer.utma.toURLString() + ";"));
            };
            if (_buffer.hasUTMZ())
            {
                _local_1.push((_buffer.utmz.toURLString() + ";"));
            };
            if (_buffer.hasUTMV())
            {
                _local_1.push((_buffer.utmv.toURLString() + ";"));
            };
            return (_local_1.join("+"));
        }

        public function get utmac():String
        {
            return (_utmac);
        }

        public function get utmwv():String
        {
            return (_config.version);
        }

        public function sendRequest(request:URLRequest):void
        {
            var loader:Loader = new Loader();
            loader.name = String(_count++);
            var context:LoaderContext = new LoaderContext(false);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _lastRequest = request;
            _requests[loader.name] = new RequestObject(request);
            try
            {
                loader.load(request, context);
            }
            catch(e:Error)
            {
                _debug.failure('"Loader.load()" could not instanciate Gif Request');
            };
        }

        private function _removeListeners(_arg_1:Object):void
        {
            _arg_1.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _arg_1.removeEventListener(Event.COMPLETE, onComplete);
        }

        public function updateToken():void
        {
            var _local_2:Number;
            var _local_1:Number = new Date().getTime();
            _local_2 = ((_local_1 - _buffer.utmb.lastTime) * (_config.tokenRate / 1000));
            if (_debug.verbose)
            {
                _debug.info(("tokenDelta: " + _local_2), VisualDebugMode.geek);
            };
            if (_local_2 >= 1)
            {
                _buffer.utmb.token = Math.min(Math.floor((_buffer.utmb.token + _local_2)), _config.bucketCapacity);
                _buffer.utmb.lastTime = _local_1;
                if (_debug.verbose)
                {
                    _debug.info(_buffer.utmb.toString(), VisualDebugMode.geek);
                };
            };
        }

        public function get utmhn():String
        {
            return (_info.domainName);
        }

        private function _shortenURL(_arg_1:String):String
        {
            var _local_2:Array;
            if (_arg_1.length > 60)
            {
                _local_2 = _arg_1.split("/");
                while (_arg_1.length > 60)
                {
                    _local_2.shift();
                    _arg_1 = ("../" + _local_2.join("/"));
                };
            };
            return (_arg_1);
        }

        private function _debugSend(_arg_1:URLRequest):void
        {
            var _local_3:String;
            var _local_2:* = "";
            switch (_debug.mode)
            {
                case VisualDebugMode.geek:
                    _local_2 = ((("Gif Request #" + _alertcount) + ":\n") + _arg_1.url);
                    break;
                case VisualDebugMode.advanced:
                    _local_3 = _arg_1.url;
                    if (_local_3.indexOf("?") > -1)
                    {
                        _local_3 = _local_3.split("?")[0];
                    };
                    _local_3 = _shortenURL(_local_3);
                    _local_2 = (((("Send Gif Request #" + _alertcount) + ":\n") + _local_3) + " ?");
                    break;
                case VisualDebugMode.basic:
                default:
                    _local_2 = (((("Send " + _config.serverMode.toString()) + " Gif Request #") + _alertcount) + " ?");
            };
            _debug.alertGifRequest(_local_2, _arg_1, this);
            _alertcount++;
        }

        public function onComplete(_arg_1:Event):void
        {
            var _local_2:String = _arg_1.target.loader.name;
            _requests[_local_2].complete();
            var _local_3:* = (("Gif Request #" + _local_2) + " sent");
            var _local_4:String = _requests[_local_2].request.url;
            if (_debug.GIFRequests)
            {
                if (!_debug.verbose)
                {
                    if (_local_4.indexOf("?") > -1)
                    {
                        _local_4 = _local_4.split("?")[0];
                    };
                    _local_4 = _shortenURL(_local_4);
                };
                if (int(_debug.mode) > int(VisualDebugMode.basic))
                {
                    _local_3 = (_local_3 + ((' to "' + _local_4) + '"'));
                };
                _debug.success(_local_3);
            }
            else
            {
                _debug.info(_local_3);
            };
            _removeListeners(_arg_1.target);
        }


    }
}//package com.google.analytics.core

