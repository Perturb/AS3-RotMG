// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot

package io.decagames.rotmg.dailyQuests.view.slot
{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class DailyQuestItemSlot extends Sprite 
    {

        public static const SLOT_SIZE:int = 40;

        private var _itemID:int;
        private var _type:String;
        private var bitmapFactory:BitmapTextFactory;
        private var imageContainer:Sprite;

        public function DailyQuestItemSlot(_arg_1:int, _arg_2:String, _arg_3:Boolean=false)
        {
            this._itemID = _arg_1;
            this._type = _arg_2;
            this.imageContainer = new Sprite();
            addChild(this.imageContainer);
            this.imageContainer.x = Math.round((SLOT_SIZE / 2));
            this.imageContainer.y = Math.round((SLOT_SIZE / 2));
            this.createBackground(_arg_3);
            this.addItem();
        }

        private function createBackground(_arg_1:Boolean=false):void
        {
            var _local_2:Shape = new Shape();
            _local_2.graphics.beginFill(((_arg_1) ? 0x13A000 : 0x454545), 1);
            _local_2.graphics.drawRect(0, 0, SLOT_SIZE, SLOT_SIZE);
            _local_2.x = -(Math.round((SLOT_SIZE / 2)));
            _local_2.y = -(Math.round((SLOT_SIZE / 2)));
            this.imageContainer.addChild(_local_2);
        }

        private function addItem():void
        {
            var _local_3:Bitmap;
            var _local_4:BitmapData;
            var _local_5:Matrix;
            var _local_1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._itemID, (SLOT_SIZE * 2), true);
            var _local_2:XML = ObjectLibrary.xmlLibrary_[this._itemID];
            this.bitmapFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
            if ((((_local_2) && (_local_2.hasOwnProperty("Quantity"))) && (this.bitmapFactory)))
            {
                _local_1 = _local_1.clone();
                _local_4 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_2.Quantity)), 12, 0xFFFFFF, false, new Matrix(), true);
                _local_5 = new Matrix();
                _local_5.translate(8, 7);
                _local_1.draw(_local_4, _local_5);
            };
            _local_3 = new Bitmap(_local_1);
            _local_3.x = -(Math.round((_local_3.width / 2)));
            _local_3.y = -(Math.round((_local_3.height / 2)));
            this.imageContainer.addChild(_local_3);
        }

        public function get itemID():int
        {
            return (this._itemID);
        }

        public function get type():String
        {
            return (this._type);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.slot

