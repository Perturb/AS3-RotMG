package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.ui.Mouse;

import kabam.rotmg.game.signals.SetWorldInteractionSignal;
import kabam.rotmg.util.components.RadioButton;

public class FakeMouse extends BasicObject
    {
        private static const AIM_IGNORE:int = -1;
        private static const AIM_STANDARD:int = 0;
        private static const AIM_PRIORITY:int = 1;

        [Inject]
        private var setWorldInteraction:SetWorldInteractionSignal;

        private var visible:Boolean;
        private var velocity:Vector3D;
        private var cursorImage:BitmapData;
        private var targetPosition:Point;
        private var reactionTime:int;
        private var relativeCheckPoints:Vector.<Point> = new Vector.<Point>();
        //player is this.map_.player_.objectId_

        public function FakeMouse()
        {
            this.visible = false;
            this.cursorImage = this.getCursor();
            this.xPosition = this.map_.mouseX;
            this.yPosition = this.map_.mouseY;
        }

        private function activate():void
        {
            this.xPosition = this.map_.mouseX;
            this.yPosition = this.map_.mouseY;
            this.visible = true;
            Mouse.hide();

            this.setWorldInteraction.dispatch(false);
            map_.gs_.stage.removeEventListener();
            map_.gs_.map.removeEventListener();
        }

        private function disable():void
        {
            Mouse.show();
            this.visible = false;

            this.setWorldInteraction.dispatch(true);
            map_.gs_.stage.addEventListener();
            map_.gs_.map.addEventListener();
        }

        private function getCursor():BitmapData
        {
            return AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
        }

        private function returnToMouse():void
        {
            //yep
        }

        private function idle():void
        {
            //move randomly within screen, weighted towards character
        }

        private function getTargetObject():void
        {
            var _local_1:GameObject;
            var _local_2:GameObject;
            var _local_3:GameObject;
            var _local_6:int;
            var _local_7:Point;

            for each (_local_1 in map_.goDict_)
            {
                if (_local_1.props_.isEnemy_)
                {
                    _local_6 = this.checkAimLists(_local_1);
                    if (_local_6 == AIM_IGNORE) {
                        continue;
                    }
                    _local_7.x = _local_1.x_;
                    _local_7.y = _local_1.y_;
                    if (Parameters.data_.autoAimLead) {
                        this.aimLead(_local_7);
                    }
                    if (Parameters.data_.autoAimCheckCollisions) {
                        if (this.checkObstacles(_local_7)) {
                            continue;
                        }
                    }
                    if (_local_6 == AIM_STANDARD) {
                        if (_local_2.maxHP_ < _local_1.maxHP_) {
                            _local_2 = _local_1;
                        }
                    }
                    else if (_local_6 == AIM_PRIORITY) {
                        if (_local_3.maxHP_ < _local_1.maxHP_) {
                            _local_3 = _local_1;
                        }
                    }
                }
                else if (Parameters.data_.autoAimException.indexOf(_local_1.props_.type_) != -1)
                {

                }
            }
        }

        private function gliderMove():void
        {
            //velocity and stuff here
        }

        private function shitMove():void
        {
            //move like you are playing on a trackpad
        }

        override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
        {
            //Mmmmmm
        }

        override public function dispose():void
        {
            this.velocity = null;
            this.cursorImage = null;
        }

        private function checkAimLists(_arg_1:GameObject):int
        {
            if (Parameters.data_.autoAimIgnore.indexOf(_arg_1.props_.type_) != -1)
            {
                return AIM_IGNORE;
            }
            if (_arg_1.isInvincible())
            {
                return AIM_IGNORE;
            }
            if (_arg_1.isInvulnerable())
            {
                if (Parameters.data_.autoAimInvulnerable.indexOf(_arg_1.props_.type_) == -1)
                {
                    return AIM_IGNORE;
                }
            }
            if (Parameters.data_.autoAimPriority.indexOf(_arg_1.props_.type_) != -1)
            {
                return AIM_PRIORITY;
            }
            return AIM_STANDARD;
        }

        private function aimLead(_arg_1:Point):void
        {
            return;
        }

        private function checkObstacles(_arg_1:Point):Boolean
        {
            return true;
        }

        private function checkProjProps():void
        {
            //update path
            relativeCheckPoints.length = 0;
        }


    }
}






private function positionAt(_arg_1:int, _arg_2:Point):void
{
    var _local_5:Number;
    var _local_6:Number;
    var _local_7:Number;
    var _local_8:Number;
    var _local_9:Number;
    var _local_10:Number;
    var _local_11:Number;
    var _local_12:Number;
    var _local_13:Number;
    var _local_14:Number;
    _arg_2.x = this.startX_;
    _arg_2.y = this.startY_;
    var _local_3:Number = (_arg_1 * (this.projProps_.speed_ / 10000));
    var _local_4:Number = (((this.bulletId_ % 2) == 0) ? 0 : Math.PI);
    if (this.projProps_.wavy_)
    {
        _local_5 = (6 * Math.PI);
        _local_6 = (Math.PI / 64);
        _local_7 = (this.angle_ + (_local_6 * Math.sin((_local_4 + ((_local_5 * _arg_1) / 1000)))));
        _arg_2.x = (_arg_2.x + (_local_3 * Math.cos(_local_7)));
        _arg_2.y = (_arg_2.y + (_local_3 * Math.sin(_local_7)));
    }
    else
    {
        if (this.projProps_.parametric_)
        {
            _local_8 = (((_arg_1 / this.projProps_.lifetime_) * 2) * Math.PI);
            _local_9 = (Math.sin(_local_8) * ((this.bulletId_ % 2) ? 1 : -1));
            _local_10 = (Math.sin((2 * _local_8)) * (((this.bulletId_ % 4) < 2) ? 1 : -1));
            _local_11 = Math.sin(this.angle_);
            _local_12 = Math.cos(this.angle_);
            _arg_2.x = (_arg_2.x + (((_local_9 * _local_12) - (_local_10 * _local_11)) * this.projProps_.magnitude_));
            _arg_2.y = (_arg_2.y + (((_local_9 * _local_11) + (_local_10 * _local_12)) * this.projProps_.magnitude_));
        }
        else
        {
            if (this.projProps_.boomerang_)
            {
                _local_13 = ((this.projProps_.lifetime_ * (this.projProps_.speed_ / 10000)) / 2);
                if (_local_3 > _local_13)
                {
                    _local_3 = (_local_13 - (_local_3 - _local_13));
                }
            }
            _arg_2.x = (_arg_2.x + (_local_3 * Math.cos(this.angle_)));
            _arg_2.y = (_arg_2.y + (_local_3 * Math.sin(this.angle_)));
            if (this.projProps_.amplitude_ != 0)
            {
                _local_14 = (this.projProps_.amplitude_ * Math.sin((_local_4 + ((((_arg_1 / this.projProps_.lifetime_) * this.projProps_.frequency_) * 2) * Math.PI))));
                _arg_2.x = (_arg_2.x + (_local_14 * Math.cos((this.angle_ + (Math.PI / 2)))));
                _arg_2.y = (_arg_2.y + (_local_14 * Math.sin((this.angle_ + (Math.PI / 2)))));
            }
        }
    }
}

public function moveTo(_arg_1:Number, _arg_2:Number):Boolean
{
    var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
    if (_local_3 == null)
    {
        return (false);
    }
    x_ = _arg_1;
    y_ = _arg_2;
    square_ = _local_3;
    return (true);
}

this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
public function onRenderSwitch(_arg_1:Boolean):void
{
    if (_arg_1)
    {
        this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }
    else
    {
        this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }
}

if ((!(this.projProps_.passesCover_)) && (square_.obj_.props_.occupySquare_))
{
    //yep
}