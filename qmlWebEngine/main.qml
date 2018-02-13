/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Window 2.0
import QtWebEngine 1.3

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true

    WebEngineView {
        id: webEngine
        anchors.fill: parent
        url:  'https://plogin.m.jd.com/user/login.action?appid=?'
//        settings.javascriptCanAccessClipboard: true
//        settings.javascriptCanOpenWindows : true
//        settings.javascriptEnabled: true
//        settings.pluginsEnabled: true
//        settings.autoLoadImages: true
        property string user: "your username here"
        property string token: "your password here"
       onLoadingChanged: {
            switch(loadRequest.status){
                case WebEngineLoadRequest.LoadSucceededStatus:{
                    autoFill("username", user)
                    autoFill("password", token)
                    autoLogin("loginBtn")
                }
            }

        }
        function autoFill(index,value){
            var queryStr = 'document.getElementById("' + index + '").value = ' + '"' + value + '"'
            console.log(queryStr)
            webEngine.runJavaScript(queryStr, function(result) { console.log(result); })
        }
        function autoLogin(btnName){
            var queryStr = 'var obj = document.getElementById("' + btnName + '")'
            console.log(queryStr)
            webEngine.runJavaScript(queryStr, function(result) { console.log(result); })
            queryStr = 'obj.className += " btn-active";'
            console.log(queryStr)
            webEngine.runJavaScript(queryStr, function(result) { console.log(result); })
            webEngine.runJavaScript('$("#loginBtn").click()')
        }

    }
}
