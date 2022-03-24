/**
 *
 * (c) Copyright Ascensio System SIA 2020
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// Example insert text into editors (different implementations)
(function(window, undefined){

    let _plugin = window.Asc.plugin

    const _placeholderPlainRich = "{\r\n\
	\"commonPr\" :\r\n\
	{\r\n\
		\"Id\" : 1,\r\n\
		\"Tag\" : \"{Document1}\",\r\n\
		\"Lock\" : 3,\r\n\
		\"Appearance\" : 1,\r\n\
		\"PlaceHolderText\":\"Place holder example\"\r\n\
	},\r\n\
	\"type\":1\r\n\
}";

    _plugin.init = function()
    {
        document.getElementById('textArea').value = _placeholderPlainRich;

        document.getElementById('buttonIDInsert').onclick = function() {

            let _val = document.getElementById("textArea").value;
            _val = _val.replaceAll("\r\n", "");
            _val = _val.replaceAll("\n", "");
            let _obj = JSON.parse(_val);

            _plugin.executeMethod('AddContentControl', [_obj.type, _obj.commonPr]);
        };
    };

    window.Asc.plugin.button = function(id)
    {
    };

})(window, undefined);
