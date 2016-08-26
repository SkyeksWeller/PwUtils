/**
 * Copyright (C), 2006-2011, ZlongGames Info.Techonology Co., Ltd.
 * Author: PengWei
 * Description:
 * Inspector这个UI调试工具的设置，在非debug情况下,需要键盘输入“inspector”来打开该功能
 * Others:
 * (其它内容的说明)
 */
package weller.util {
import cn.itamt.utils.Inspector;
import cn.itamt.utils.inspector.firefox.download.DownloadAll;
import cn.itamt.utils.inspector.firefox.reloadapp.ReloadApp;
import cn.itamt.utils.inspector.plugins.controlbar.ControlBar;
import cn.itamt.utils.inspector.plugins.fullscreen.FullScreen;
import cn.itamt.utils.inspector.plugins.gerrorkeeper.GlobalErrorKeeper;
import cn.itamt.utils.inspector.plugins.keyboard.InspectorKeyManager;
import cn.itamt.utils.inspector.plugins.stats.AppStats;
import cn.itamt.utils.inspector.plugins.swfinfo.SwfInfoView;

import flash.display.DisplayObjectContainer;
import flash.events.KeyboardEvent;

/**
 * Inspector这个UI调试工具的设置，在非debug情况下,需要键盘输入“Inspector”来打开该功能
 * @author PengWei
 * @zlonggames.com
 * @Create Date 2012-8-22
 */
public class InspectorSetting
{
    private static var _Instance : InspectorSetting;

    /*是否为debug模式*/
    private var _isDebug : Boolean;
    /*初始化UI调试界面的密码*/
    private var _password : String = "";
    /*舞台显示列表中的显示容器*/
    private var _container : DisplayObjectContainer;

    /**
     * @private
     */
    public function InspectorSetting(sington : Singleton)
    {
        sington = null;
    }

    /**
     * 清理函数
     */
    public function destroy() : void
    {
        _container = null;
        _Instance = null;
    }

    /**
     * 初始化,不能多次初始化,已第一次参数为准
     *
     * @param container 放置按钮的显示容器
     * @param isDebug 是否为调试模式
     */
    public function init(container : DisplayObjectContainer , isDebug : Boolean = true) : void
    {
        if(_container)
        {
            return;
        }
        _container = container;
        _isDebug = isDebug;

        /*debug模式下需要键盘输入密码激活该功能*/
        if(isDebug)
        {
            initInspector();
        }
        else
        {
            _container.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
        }
    }

    /*打开Inspector的密码监听*/
    private function onKeyDownHandler(e : KeyboardEvent) : void
    {
        if(_password.length >= 9)
        {
            _password = _password.substr(1, 8);
        }
        _password = _password.concat(String.fromCharCode(e.charCode));

        /*检测密码是否正确*/
        if(_password == "inspector")
        {
            initInspector();
        }
    }

    //初始化UI调试器
    private function initInspector() : void
    {
        /*初始化*/
        Inspector.getInstance().init(_container);

        //右键面板打开
        //			var rightMenuPlugin : InspectorRightMenu = new InspectorRightMenu();
        //			Inspector.getInstance().pluginManager.registerPlugin(rightMenuPlugin);
        //功能控制条
        var barPlugin : ControlBar = new ControlBar();
        Inspector.getInstance().pluginManager.registerPlugin(barPlugin);
        //貌似是键盘管理，但是好像没看出用途
        var keyInfoPlugin : InspectorKeyManager = new InspectorKeyManager();
        Inspector.getInstance().pluginManager.registerPlugin(keyInfoPlugin);
        //全屏按钮
        var fullScreenPlugin : FullScreen = new FullScreen();
        Inspector.getInstance().pluginManager.registerPlugin(fullScreenPlugin);
        //错误信息面板
        var errorInfoPlugin : GlobalErrorKeeper = new GlobalErrorKeeper();
        Inspector.getInstance().pluginManager.registerPlugin(errorInfoPlugin);
        //FPS，内存使用等情况面板
        var statsPlugin : AppStats = new AppStats();
        Inspector.getInstance().pluginManager.registerPlugin(statsPlugin);
        //swf信息,画质，帧频等
        var swfInfoPlugin : SwfInfoView = new SwfInfoView();
        Inspector.getInstance().pluginManager.registerPlugin(swfInfoPlugin);
        //download
        var downLoadPlugin : DownloadAll = new DownloadAll();
        Inspector.getInstance().pluginManager.registerPlugin(downLoadPlugin);
        //ReloadApp
        var reloadPlugin : ReloadApp = new ReloadApp();
        Inspector.getInstance().pluginManager.registerPlugin(reloadPlugin);
    }


    //----------------------------------------------------------------------
    //--------------------------getter setter-------------------------------
    //----------------------------------------------------------------------
    public static function get instance() : InspectorSetting
    {
        if(_Instance == null)
        {
            _Instance = new InspectorSetting(new Singleton());
        }
        return _Instance;
    }
}
}

internal class Singleton
{
}

