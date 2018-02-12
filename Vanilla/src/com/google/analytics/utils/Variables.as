// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.utils.Variables

package com.google.analytics.utils
{
    import flash.net.URLVariables;

    public dynamic class Variables 
    {

        public var URIencode:Boolean;
        public var sort:Boolean = true;

        public var pre:Array = [];
        public var post:Array = [];

        public function Variables(_arg_1:String=null, _arg_2:Array=null, _arg_3:Array=null)
        {
            if (_arg_1)
            {
                decode(_arg_1);
            };
            if (_arg_2)
            {
                this.pre = _arg_2;
            };
            if (_arg_3)
            {
                this.post = _arg_3;
            };
        }

        private function _join(_arg_1:Variables):void
        {
            var _local_2:String;
            if (!_arg_1)
            {
                return;
            };
            for (_local_2 in _arg_1)
            {
                this[_local_2] = _arg_1[_local_2];
            };
        }

        public function join(... _args):void
        {
            var _local_2:int = _args.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if ((_args[_local_3] is Variables))
                {
                    _join(_args[_local_3]);
                };
                _local_3++;
            };
        }

        public function toString():String
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_1:Array = [];
            for (_local_3 in this)
            {
                _local_2 = this[_local_3];
                if (URIencode)
                {
                    _local_2 = encodeURI(_local_2);
                };
                _local_1.push(((_local_3 + "=") + _local_2));
            };
            if (sort)
            {
                _local_1.sort();
            };
            if (pre.length > 0)
            {
                pre.reverse();
                _local_5 = 0;
                while (_local_5 < pre.length)
                {
                    _local_7 = pre[_local_5];
                    _local_6 = 0;
                    while (_local_6 < _local_1.length)
                    {
                        _local_4 = _local_1[_local_6];
                        if (_local_4.indexOf(_local_7) == 0)
                        {
                            _local_1.unshift(_local_1.splice(_local_6, 1)[0]);
                        };
                        _local_6++;
                    };
                    _local_5++;
                };
                pre.reverse();
            };
            if (post.length > 0)
            {
                _local_5 = 0;
                while (_local_5 < post.length)
                {
                    _local_8 = post[_local_5];
                    _local_6 = 0;
                    while (_local_6 < _local_1.length)
                    {
                        _local_4 = _local_1[_local_6];
                        if (_local_4.indexOf(_local_8) == 0)
                        {
                            _local_1.push(_local_1.splice(_local_6, 1)[0]);
                        };
                        _local_6++;
                    };
                    _local_5++;
                };
            };
            return (_local_1.join("&"));
        }

        public function decode(_arg_1:String):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:Array;
            if (_arg_1 == "")
            {
                return;
            };
            if (_arg_1.charAt(0) == "?")
            {
                _arg_1 = _arg_1.substr(1, _arg_1.length);
            };
            if (_arg_1.indexOf("&") > -1)
            {
                _local_2 = _arg_1.split("&");
            }
            else
            {
                _local_2 = [_arg_1];
            };
            var _local_7:int;
            while (_local_7 < _local_2.length)
            {
                _local_3 = _local_2[_local_7];
                if (_local_3.indexOf("=") > -1)
                {
                    _local_6 = _local_3.split("=");
                    _local_4 = _local_6[0];
                    _local_5 = decodeURI(_local_6[1]);
                    this[_local_4] = _local_5;
                };
                _local_7++;
            };
        }

        public function toURLVariables():URLVariables
        {
            var _local_2:String;
            var _local_1:URLVariables = new URLVariables();
            for (_local_2 in this)
            {
                _local_1[_local_2] = this[_local_2];
            };
            return (_local_1);
        }


    }
}//package com.google.analytics.utils

