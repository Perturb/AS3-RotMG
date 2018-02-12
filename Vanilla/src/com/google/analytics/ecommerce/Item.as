// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.ecommerce.Item

package com.google.analytics.ecommerce
{
    import com.google.analytics.utils.Variables;

    public class Item 
    {

        private var _price:String;
        private var _id:String;
        private var _sku:String;
        private var _category:String;
        private var _quantity:String;
        private var _name:String;

        public function Item(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String)
        {
            this._id = _arg_1;
            this._sku = _arg_2;
            this._name = _arg_3;
            this._category = _arg_4;
            this._price = _arg_5;
            this._quantity = _arg_6;
        }

        public function set sku(_arg_1:String):void
        {
            _sku = _arg_1;
        }

        public function get price():String
        {
            return (_price);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get quantity():String
        {
            return (_quantity);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set price(_arg_1:String):void
        {
            _price = _arg_1;
        }

        public function get id():String
        {
            return (_id);
        }

        public function get sku():String
        {
            return (_sku);
        }

        public function set quantity(_arg_1:String):void
        {
            _quantity = _arg_1;
        }

        public function toGifParams():Variables
        {
            var _local_1:Variables = new Variables();
            _local_1.URIencode = true;
            _local_1.post = ["utmt", "utmtid", "utmipc", "utmipn", "utmiva", "utmipr", "utmiqt"];
            _local_1.utmt = "item";
            _local_1.utmtid = _id;
            _local_1.utmipc = _sku;
            _local_1.utmipn = _name;
            _local_1.utmiva = _category;
            _local_1.utmipr = _price;
            _local_1.utmiqt = _quantity;
            return (_local_1);
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        public function set category(_arg_1:String):void
        {
            _category = _arg_1;
        }

        public function get category():String
        {
            return (_category);
        }


    }
}//package com.google.analytics.ecommerce

