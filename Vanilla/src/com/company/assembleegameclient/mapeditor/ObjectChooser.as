// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.ObjectChooser

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

    internal class ObjectChooser extends Chooser 
    {

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function ObjectChooser(_arg_1:String="")
        {
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.reloadObjects(_arg_1, true);
        }

        public function getLastSearch():String
        {
            return (this.lastSearch);
        }

        public function reloadObjects(_arg_1:String="", _arg_2:Boolean=false):void
        {
            var _local_4:RegExp;
            var _local_6:String;
            var _local_7:XML;
            var _local_8:int;
            var _local_9:ObjectElement;
            if (!_arg_2)
            {
                removeElements();
            };
            this.lastSearch = _arg_1;
            var _local_3:Vector.<String> = new Vector.<String>();
            if (_arg_1 != "")
            {
                _local_4 = new RegExp(_arg_1, "gix");
            };
            var _local_5:Dictionary = GroupDivider.GROUPS["Basic Objects"];
            for each (_local_7 in _local_5)
            {
                _local_6 = String(_local_7.@id);
                if (((_local_4 == null) || (_local_6.search(_local_4) >= 0)))
                {
                    _local_3.push(_local_6);
                };
            };
            _local_3.sort(MoreStringUtil.cmp);
            for each (_local_6 in _local_3)
            {
                _local_8 = ObjectLibrary.idToType_[_local_6];
                _local_7 = ObjectLibrary.xmlLibrary_[_local_8];
                if (!this.cache[_local_8])
                {
                    _local_9 = new ObjectElement(_local_7);
                    this.cache[_local_8] = _local_9;
                }
                else
                {
                    _local_9 = this.cache[_local_8];
                };
                addElement(_local_9);
            };
            scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

