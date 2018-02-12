// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.ecommerce.Transaction

package com.google.analytics.ecommerce
{
    import com.google.analytics.utils.Variables;

    public class Transaction 
    {

        private var _items:Array;
        private var _total:String;
        private var _vars:Variables;
        private var _shipping:String;
        private var _city:String;
        private var _state:String;
        private var _country:String;
        private var _tax:String;
        private var _affiliation:String;
        private var _id:String;

        public function Transaction(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:String, _arg_8:String)
        {
            this._id = _arg_1;
            this._affiliation = _arg_2;
            this._total = _arg_3;
            this._tax = _arg_4;
            this._shipping = _arg_5;
            this._city = _arg_6;
            this._state = _arg_7;
            this._country = _arg_8;
            _items = new Array();
        }

        public function get total():String
        {
            return (_total);
        }

        public function getItemFromArray(_arg_1:Number):Item
        {
            return (_items[_arg_1]);
        }

        public function set total(_arg_1:String):void
        {
            _total = _arg_1;
        }

        public function getItem(_arg_1:String):Item
        {
            var _local_2:Number;
            _local_2 = 0;
            while (_local_2 < _items.length)
            {
                if (_items[_local_2].sku == _arg_1)
                {
                    return (_items[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }

        public function getItemsLength():Number
        {
            return (_items.length);
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String):void
        {
            var _local_6:Item;
            _local_6 = getItem(_arg_1);
            if (_local_6 == null)
            {
                _local_6 = new Item(_id, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                _items.push(_local_6);
            }
            else
            {
                _local_6.name = _arg_2;
                _local_6.category = _arg_3;
                _local_6.price = _arg_4;
                _local_6.quantity = _arg_5;
            };
        }

        public function set shipping(_arg_1:String):void
        {
            _shipping = _arg_1;
        }

        public function get country():String
        {
            return (_country);
        }

        public function get state():String
        {
            return (_state);
        }

        public function set tax(_arg_1:String):void
        {
            _tax = _arg_1;
        }

        public function set affiliation(_arg_1:String):void
        {
            _affiliation = _arg_1;
        }

        public function set state(_arg_1:String):void
        {
            _state = _arg_1;
        }

        public function get id():String
        {
            return (_id);
        }

        public function get tax():String
        {
            return (_tax);
        }

        public function toGifParams():Variables
        {
            var _local_1:Variables = new Variables();
            _local_1.URIencode = true;
            _local_1.utmt = "tran";
            _local_1.utmtid = id;
            _local_1.utmtst = affiliation;
            _local_1.utmtto = total;
            _local_1.utmttx = tax;
            _local_1.utmtsp = shipping;
            _local_1.utmtci = city;
            _local_1.utmtrg = state;
            _local_1.utmtco = country;
            _local_1.post = ["utmtid", "utmtst", "utmtto", "utmttx", "utmtsp", "utmtci", "utmtrg", "utmtco"];
            return (_local_1);
        }

        public function get affiliation():String
        {
            return (_affiliation);
        }

        public function get city():String
        {
            return (_city);
        }

        public function get shipping():String
        {
            return (_shipping);
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        public function set city(_arg_1:String):void
        {
            _city = _arg_1;
        }

        public function set country(_arg_1:String):void
        {
            _country = _arg_1;
        }


    }
}//package com.google.analytics.ecommerce

