// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElement

package io.decagames.rotmg.dailyQuests.view.list
{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.filters.DropShadowFilter;
    import flash.filters.BitmapFilterQuality;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.display.Bitmap;
    import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;

    public class DailyQuestListElement extends Sprite 
    {

        private var _id:String;
        private var _questName:String;
        private var _completed:Boolean;
        private var selectedBorder:Sprite;
        private var _isSelected:Boolean;
        private var ready:Boolean;
        private var background:Sprite = new Sprite();
        private var questNameTextfield:TextFieldDisplayConcrete;
        private var category:int;

        public function DailyQuestListElement(_arg_1:String, _arg_2:String, _arg_3:Boolean, _arg_4:Boolean, _arg_5:int)
        {
            this._id = _arg_1;
            this._questName = _arg_2;
            this._completed = _arg_3;
            this.ready = _arg_4;
            this.category = _arg_5;
            this.selectedBorder = new Sprite();
            this.draw();
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
            this.drawBackground();
            this.setElements();
        }

        private function setElements():void
        {
            if (((this.questNameTextfield) && (this.questNameTextfield.parent)))
            {
                removeChild(this.questNameTextfield);
            };
            this.questNameTextfield = new TextFieldDisplayConcrete().setSize(14).setColor(((this.category == 3) ? 2201331 : (((this._completed) || (this._isSelected)) ? 0xFFFFFF : 0xCFCFCF))).setBold(true);
            this.questNameTextfield.alpha = (((this._completed) || (this._isSelected)) ? 1 : 0.5);
            this.questNameTextfield.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            this.questNameTextfield.setStringBuilder(new StaticStringBuilder(this._questName));
            this.questNameTextfield.x = 24;
            this.questNameTextfield.y = 8;
            addChild(this.questNameTextfield);
        }

        private function draw():void
        {
            this.drawBackground();
            this.setElements();
        }

        private function drawBackground():void
        {
            var _local_1:Bitmap;
            if (this.background.parent)
            {
                removeChild(this.background);
            };
            this.background = new Sprite();
            if (this._completed)
            {
                _local_1 = new DailyQuestAssets.DailyQuestsListCompleteIcon();
            }
            else
            {
                if (this.ready)
                {
                    _local_1 = new DailyQuestAssets.DailyQuestsListReadyIcon();
                }
                else
                {
                    _local_1 = new DailyQuestAssets.DailyQuestsListAvailableIcon();
                };
            };
            _local_1.x = 5;
            _local_1.y = 5;
            if (this._isSelected)
            {
                this.background.addChild(new DailyQuestAssets.DailyQuestsListElementOrange());
            }
            else
            {
                if (this._completed)
                {
                    this.background.addChild(new DailyQuestAssets.DailyQuestsListElementGreen());
                }
                else
                {
                    this.background.addChild(new DailyQuestAssets.DailyQuestsListElementGrey());
                };
            };
            addChild(this.background);
            addChild(_local_1);
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get questName():String
        {
            return (this._questName);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

