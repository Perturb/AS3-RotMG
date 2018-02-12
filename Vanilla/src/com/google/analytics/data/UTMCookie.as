// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMCookie

package com.google.analytics.data
{
    import com.google.analytics.core.Buffer;

    public class UTMCookie implements Cookie 
    {

        protected var inURL:String;
        protected var name:String;
        private var _creation:Date;
        private var _expiration:Date;
        public var proxy:Buffer;
        protected var fields:Array;
        private var _timespan:Number;

        public function UTMCookie(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:Number=0)
        {
            this.name = _arg_1;
            this.inURL = _arg_2;
            this.fields = _arg_3;
            _timestamp(_arg_4);
        }

        public function isEmpty():Boolean
        {
            var _local_2:String;
            var _local_1:int;
            var _local_3:int;
            while (_local_3 < fields.length)
            {
                _local_2 = fields[_local_3];
                if (((this[_local_2] is Number) && (isNaN(this[_local_2]))))
                {
                    _local_1++;
                }
                else
                {
                    if (((this[_local_2] is String) && (this[_local_2] == "")))
                    {
                        _local_1++;
                    };
                };
                _local_3++;
            };
            if (_local_1 == fields.length)
            {
                return (true);
            };
            return (false);
        }

        public function resetTimestamp(_arg_1:Number=NaN):void
        {
            if (!isNaN(_arg_1))
            {
                _timespan = _arg_1;
            };
            _creation = null;
            _expiration = null;
            _timestamp(_timespan);
        }

        protected function update():void
        {
            resetTimestamp();
            if (proxy)
            {
                proxy.update(name, toSharedObject());
            };
        }

        public function reset():void
        {
            var _local_1:String;
            var _local_2:int;
            while (_local_2 < fields.length)
            {
                _local_1 = fields[_local_2];
                if ((this[_local_1] is Number))
                {
                    this[_local_1] = NaN;
                }
                else
                {
                    if ((this[_local_1] is String))
                    {
                        this[_local_1] = "";
                    };
                };
                _local_2++;
            };
            resetTimestamp();
            update();
        }

        public function fromSharedObject(_arg_1:Object):void
        {
            var _local_2:String;
            var _local_3:int = fields.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_2 = fields[_local_4];
                if (_arg_1[_local_2])
                {
                    this[_local_2] = _arg_1[_local_2];
                };
                _local_4++;
            };
            if (_arg_1.creation)
            {
                this.creation = _arg_1.creation;
            };
            if (_arg_1.expiration)
            {
                this.expiration = _arg_1.expiration;
            };
        }

        private function _timestamp(_arg_1:Number):void
        {
            creation = new Date();
            _timespan = _arg_1;
            if (_arg_1 > 0)
            {
                expiration = new Date((creation.valueOf() + _arg_1));
            };
        }

        public function isExpired():Boolean
        {
            var _local_1:Date = new Date();
            var _local_2:Number = (expiration.valueOf() - _local_1.valueOf());
            if (_local_2 <= 0)
            {
                return (true);
            };
            return (false);
        }

        public function set expiration(_arg_1:Date):void
        {
            _expiration = _arg_1;
        }

        public function get creation():Date
        {
            return (_creation);
        }

        public function valueOf():String
        {
            var _local_2:String;
            var _local_3:*;
            var _local_4:Array;
            var _local_1:Array = [];
            var _local_5:* = "";
            var _local_6:int;
            while (_local_6 < fields.length)
            {
                _local_2 = fields[_local_6];
                _local_3 = this[_local_2];
                if ((_local_3 is String))
                {
                    if (_local_3 == "")
                    {
                        _local_3 = "-";
                        _local_1.push(_local_3);
                    }
                    else
                    {
                        _local_1.push(_local_3);
                    };
                }
                else
                {
                    if ((_local_3 is Number))
                    {
                        if (_local_3 == 0)
                        {
                            _local_1.push(_local_3);
                        }
                        else
                        {
                            if (isNaN(_local_3))
                            {
                                _local_3 = "-";
                                _local_1.push(_local_3);
                            }
                            else
                            {
                                _local_1.push(_local_3);
                            };
                        };
                    };
                };
                _local_6++;
            };
            if (isEmpty())
            {
                return ("-");
            };
            return ("" + _local_1.join("."));
        }

        public function toURLString():String
        {
            return ((inURL + "=") + valueOf());
        }

        public function get expiration():Date
        {
            if (_expiration)
            {
                return (_expiration);
            };
            return (new Date((new Date().valueOf() + 1000)));
        }

        public function toSharedObject():Object
        {
            var _local_2:String;
            var _local_3:*;
            var _local_1:Object = {};
            var _local_4:int;
            while (_local_4 < fields.length)
            {
                _local_2 = fields[_local_4];
                _local_3 = this[_local_2];
                if ((_local_3 is String))
                {
                    _local_1[_local_2] = _local_3;
                }
                else
                {
                    if (_local_3 == 0)
                    {
                        _local_1[_local_2] = _local_3;
                    }
                    else
                    {
                        if (!isNaN(_local_3))
                        {
                            _local_1[_local_2] = _local_3;
                        };
                    };
                };
                _local_4++;
            };
            _local_1.creation = creation;
            _local_1.expiration = expiration;
            return (_local_1);
        }

        public function toString(_arg_1:Boolean=false):String
        {
            var _local_3:String;
            var _local_4:*;
            var _local_2:Array = [];
            var _local_5:int = fields.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_3 = fields[_local_6];
                _local_4 = this[_local_3];
                if ((_local_4 is String))
                {
                    _local_2.push((((_local_3 + ': "') + _local_4) + '"'));
                }
                else
                {
                    if (_local_4 == 0)
                    {
                        _local_2.push(((_local_3 + ": ") + _local_4));
                    }
                    else
                    {
                        if (!isNaN(_local_4))
                        {
                            _local_2.push(((_local_3 + ": ") + _local_4));
                        };
                    };
                };
                _local_6++;
            };
            var _local_7:* = (((name.toUpperCase() + " {") + _local_2.join(", ")) + "}");
            if (_arg_1)
            {
                _local_7 = (_local_7 + (((" creation:" + creation) + ", expiration:") + expiration));
            };
            return (_local_7);
        }

        public function set creation(_arg_1:Date):void
        {
            _creation = _arg_1;
        }


    }
}//package com.google.analytics.data

