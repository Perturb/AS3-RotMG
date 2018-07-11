// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CurrentCharacterMediator

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.util.MoreDateUtil;

import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.core.signals.TrackPageViewSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.packages.control.InitPackagesSignal;
import kabam.rotmg.ui.signals.ChooseNameSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CurrentCharacterMediator extends Mediator
    {

        [Inject]
        public var view:CharacterSelectionAndNewsScreen;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var chooseName:ChooseNameSignal;
        [Inject]
        public var nameChanged:NameChangedSignal;
        [Inject]
        public var trackPage:TrackPageViewSignal;
        [Inject]
        public var initPackages:InitPackagesSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var securityQuestionsModel:SecurityQuestionsModel;


        override public function initialize():void
        {
            this.trackSomething();
            this.view.initialize(this.playerModel);
            this.view.close.add(this.onClose);
            this.view.newCharacter.add(this.onNewCharacter);
            this.view.showClasses.add(this.onNewCharacter);
            this.view.chooseName.add(this.onChooseName);
            this.view.playGame.add(this.onPlayGame);
            this.trackPage.dispatch("/currentCharScreen");
            this.nameChanged.add(this.onNameChanged);
            this.initPackages.dispatch();
            if (this.securityQuestionsModel.showSecurityQuestionsOnStartup)
            {
                this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
            }
        }

        override public function destroy():void
        {
            this.nameChanged.remove(this.onNameChanged);
            this.view.close.remove(this.onClose);
            this.view.newCharacter.remove(this.onNewCharacter);
            this.view.chooseName.remove(this.onChooseName);
            this.view.showClasses.remove(this.onNewCharacter);
            this.view.playGame.remove(this.onPlayGame);
        }

        private function onNameChanged(_arg_1:String):void
        {
            this.view.setName(_arg_1);
        }

        private function trackSomething():void
        {
            var _local_2:TrackingData;
            var _local_1:String = MoreDateUtil.getDayStringInPT();
            if (Parameters.data_.lastDailyAnalytics != _local_1)
            {
                _local_2 = new TrackingData();
                _local_2.category = "joinDate";
                _local_2.action = Parameters.data_.joinDate;
                Parameters.data_.lastDailyAnalytics = _local_1;
                Parameters.save();
            }
        }

        private function onNewCharacter():void
        {
            this.setScreen.dispatch(new NewCharacterScreen());
        }

        private function onClose():void
        {
            this.setScreen.dispatch(new TitleView());
        }

        private function onChooseName():void
        {
            this.chooseName.dispatch();
        }

        private function onPlayGame():void
        {
            var _local_1:SavedCharacter = this.playerModel.getCharacterByIndex(0);
            this.playerModel.currentCharId = _local_1.charId();
            var _local_2:CharacterClass = this.classesModel.getCharacterClass(_local_1.objectType());
            _local_2.setIsSelected(true);
            _local_2.skins.getSkin(_local_1.skinType()).setIsSelected(true);
            var _local_3:TrackingData = new TrackingData();
            _local_3.category = "character";
            _local_3.action = "select";
            _local_3.label = _local_1.displayId();
            _local_3.value = _local_1.level();
            var _local_4:GameInitData = new GameInitData();
            _local_4.createCharacter = false;
            _local_4.charId = _local_1.charId();
            _local_4.isNewGame = true;
            this.playGame.dispatch(_local_4);
        }


    }
}//package kabam.rotmg.ui.view

