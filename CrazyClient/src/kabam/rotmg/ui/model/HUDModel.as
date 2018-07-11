// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.ui.model.HUDModel

package kabam.rotmg.ui.model
{
import com.company.assembleegameclient.game.GameSprite;

public class HUDModel
    {

        public var gameSprite:GameSprite;


        public function getPlayerName():String
        {
            return ((this.gameSprite.model.getName()) ? this.gameSprite.model.getName() : this.gameSprite.map.player_.name_);
        }

        public function getButtonType():String
        {
            return ((this.gameSprite.gsc_.gameId_ == -2) ? "OPTIONS_BUTTON" : "NEXUS_BUTTON");
        }


    }
}//package kabam.rotmg.ui.model

