// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.AllObjectChooser

package com.company.assembleegameclient.mapeditor
{
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.mapeditor.Layer;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.mapeditor.GroupDivider;
    import com.company.util.MoreStringUtil;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import __AS3__.vec.*;
    import com.company.assembleegameclient.mapeditor.*;

    internal class AllObjectChooser extends Chooser 
    {

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function AllObjectChooser(_arg_1:String="", _arg_2:String="All Map Objects")
        {
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.reloadObjects(_arg_1, true, _arg_2);
        }

        public function getLastSearch():String
        {
            return (this.lastSearch);
        }

        public function reloadObjects(_arg_1:String="", _arg_2:Boolean=false, _arg_3:String="All Map Objects"):void
        {
            var _local_5:RegExp;
            var _local_7:String;
            var _local_8:int;
            var _local_9:XML;
            var _local_10:int;
            var _local_11:ObjectElement;
            if (!_arg_2)
            {
                removeElements();
            };
            this.lastSearch = _arg_1;
            var _local_4:Vector.<String> = new Vector.<String>();
            if (_arg_1 != "")
            {
                _local_5 = new RegExp(_arg_1, "gix");
            };
            var _local_6:Dictionary = GroupDivider.GROUPS[_arg_3];
            for each (_local_9 in _local_6)
            {
                _local_7 = String(_local_9.@id);
                _local_8 = int(_local_9.@type);
                if ((((_local_5 == null) || (_local_7.search(_local_5) >= 0)) || (_local_8 == int(_arg_1))))
                {
                    _local_4.push(_local_7);
                };
            };
            _local_4.sort(MoreStringUtil.cmp);
            for each (_local_7 in _local_4)
            {
                _local_10 = ObjectLibrary.idToType_[_local_7];
                _local_9 = ObjectLibrary.xmlLibrary_[_local_10];
                if (!this.cache[_local_10])
                {
                    _local_11 = new ObjectElement(_local_9);
                    if (_arg_3 == "All Game Objects")
                    {
                        _local_11.downloadOnly = true;
                    };
                    this.cache[_local_10] = _local_11;
                }
                else
                {
                    _local_11 = this.cache[_local_10];
                };
                addElement(_local_11);
            };
            scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

