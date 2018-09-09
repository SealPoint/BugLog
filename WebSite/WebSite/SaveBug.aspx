<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaveBug.aspx.cs" Inherits="WebSite.SaveBug" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report a Bug</title>
    <style type="text/css">
        .body
        {
            background-color: #A0B6D4;
            font-family: Calibri;
            color: #222222;
        }
        
        .headerPad
        {
            position: absolute;
            width: 500px;
            height: 100px;
            z-index: 15;
            top: 30%;
            left: 48%;
            margin: -100px 0 0 -150px;
            font-family: Edwardian Script ITC;
            font-size: 48pt;
        }
        .centralPad
        {
            position: absolute;
            width: 700px;
            height: 200px;
            z-index: 15;
            top: 42%;
            left: 40%;
            margin: -100px 0 0 -150px;
        }
        .title
        {
            width: 500px;
        }
        .subtitle
        {
            font-family: Calibri;
            font-size: 12pt;
        }
        .gap
        {
            height: 10px;
        }
        .description
        {
            font-family: Calibri;
            font-size: 12pt;
            width: 500px;
            height: 300px;
        }
        .select
        {
            /* This will create a positioning context for the list of options */
            position: relative;
 
            /* This will make our widget become part of the text flow and sizable at the same time */
            display: inline-block;
        }
        
        .select.active,
        .select:focus
        {
            outline: none;
            border: solid 2px #953735;
 
            /* This box-shadow property is not exactly required, however it's so important to be sure
            the active state is visible that we use it as a default value, feel free to override it. */
            /*box-shadow: 0 0 3px 1px #227755;*/
        }
        
        /* The .select selector here is syntactic sugar to be sure the classes we define are
           the ones inside our widget. */
        .select .optList
        {
            /* This will make sure our list of options will be displayed below the value
               and out of the HTML flow */
            position: absolute;
            top: 100%;
            left: 0;
        }
        
        .select .optList.hidden
        {
            /* This is a simple way to hide the list in an accessible way, 
               we will talk more about accessibility in the end */
            max-height: 0;
            visibility: hidden;
        }
        
        .select
        {
            /* All sizes will be expressed with the em value for accessibility reasons
              (to make sure the widget remains resizable if the user uses the  
               browser's zoom in a text-only mode). The computations are made
               assuming 1em == 16px which is the default value in most browsers.
               If you are lost with px to em conversion, try http://riddle.pl/emcalc/ */
            font-size: 0.625em; /* this (10px) is the new font size context for em value in this context */
            font-family: Verdana, Arial, sans-serif;

            -moz-box-sizing: border-box;
            box-sizing: border-box;

            /* We need extra room for the down arrow we will add */
            padding: .1em 2.5em .2em .5em; /* 1px 25px 2px 5px */
            width: 10em; /* 100px */

            border: .2em solid #000; /* 2px */
            /*box-shadow: 0 .1em .2em rgba(0,0,0,.45); 0 1px 2px */
        }
        
        .select .value
        {
            /* Because the value can be wider than our widget, we have to make sure it will not
               change the widget's width */
            display: inline-block;
            width: 100%;
            overflow: hidden;

            vertical-align: top;

            /* And if the content overflows, it's better to have a nice ellipsis. */
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        
        .select:after
        {
            content: ">"; /* We use the unicode caracter U+25BC; see http://www.utf8-chartable.de */
            font: bold 17px "Consolas", monospace;
            transform: rotate(90deg);
            position: absolute;
            z-index: 1; /* This will be important to keep the arrow from overlapping the list of options */
            top: -2px;
            right: 2px;
            

            -moz-box-sizing: border-box;
            box-sizing: content-box;

            height: 20px;
            width: 16px;  /* 20px */
            vertical-align: middle;

            /*border-left: .2em solid #000; 2px */

            /* The first declaration is for browsers that do not support linear gradients.
               The second declaration is because WebKit based browsers haven't unprefixed it yet.
               If you want to support legacy browsers, try http://www.colorzilla.com/gradient-editor/ */
            background: #D0D0D0;
            /*background: -webkit-linear-gradient(90deg, #E3E3E3, #fcfcfc);
            background: linear-gradient(270deg, #C0C0C0, #fcfcfc);*/
            text-align: center;
        }
        
        .select .optList
        {
            z-index: 2; /* We explicitly said the list of options will always overlap the down arrow */

            /* This will reset the default style of the ul element */
            list-style: none;
            margin: 0;
            padding: 0;

            -moz-box-sizing: border-box;
            box-sizing: border-box;

            /* This will ensure that even if the values are smaller than the widget,
               the list of options will be as large as the widget itself */
            min-width: 100%;

            /* In case the list is too long, its content will overflow vertically 
               (which will add a vertical scrollbar automatically) but never horizontally 
               (because we haven't set a width, the list will adjust its width automatically. 
                If it can't, the content will be truncated) */
            max-height: 10em; /* 100px */
            overflow-y: auto;
            overflow-x: hidden;

            border: .2em solid #000; /* 2px */
            border-top-width : .1em; /* 1px */
            border-radius: 0 0 .4em .4em; /* 0 0 4px 4px */

            box-shadow: 0 .2em .4em rgba(0,0,0,.4); /* 0 2px 4px */
            background: #f0f0f0;
        }
        
        .select .option
        {
            padding: .2em .3em; /* 2px 3px */
        }

        .select .highlight
        {
            background: #000;
            color: #FFFFFF;
        }
    </style>
    <script type="text/javascript" language="javascript">
        NodeList.prototype.forEach = function(callback)
        {
            Array.prototype.forEach.call(this, callback);
        }

        // This function will be used each time we want to deactivate a custom widget
        // It takes one parameter
        // select : the DOM node with the `select` class to deactivate
        function deactivateSelect(select) {
            // If the widget is not active there is nothing to do
            if (!select.classList.contains('active'))
            {
                return;
            }

            // We need to get the list of options for the custom widget
            var optList = select.querySelector('.optList');

            // We close the list of option
            optList.classList.add('hidden');

            // and we deactivate the custom widget itself
            select.classList.remove('active');
        }

        // This function will be used each time the user wants to (de)activate the widget
        // It takes two parameters:
        // select : the DOM node with the `select` class to activate
        // selectList : the list of all the DOM nodes with the `select` class
        function activeSelect(select, selectList) {
            // If the widget is already active there is nothing to do
            if (select.classList.contains('active'))
            {
                return;
            }

            // We have to turn off the active state on all custom widgets
            // Because the deactivateSelect function fulfill all the requirement of the
            // forEach callback function, we use it directly without using an intermediate
            // anonymous function.
            //selectList.forEach(deactivateSelect);

            // And we turn on the active state for this specific widget
            select.classList.add('active');
        }

        // This function will be used each time the user wants to open/closed the list of options
        // It takes one parameter:
        // select : the DOM node with the list to toggle
        function toggleOptList(select) {
            // The list is kept from the widget
            var optList = select.querySelector('.optList');

            // We change the class of the list to show/hide it
            optList.classList.toggle('hidden');
        }

        // This function will be used each time we need to highlight an option
        // It takes two parameters:
        // select : the DOM node with the `select` class containing the option to highlight
        // option : the DOM node with the `option` class to highlight
        function highlightOption(select, option)
        {
            // We get the list of all option available for our custom select element
            var optionList = select.querySelectorAll('.option');

            // We remove the highlight from all options
            optionList.forEach(function(other) {
                other.classList.remove('highlight');
            });

            // We highlight the right option
            option.classList.add('highlight');
        };

        // This function updates the displayed value and synchronizes it with the native widget.
        // It takes two parameters:
        // select : the DOM node with the class `select` containing the value to update
        // index  : the index of the value to be selected
        function updateValue(select, option) {
            // We also need  to get the value placeholder of our custom widget
            var value = select.querySelector('.value');

            // We update the value placeholder accordingly
            value.innerHTML = option.innerHTML;
        };

        // This function returns the current selected index in the native widget
        // It takes one parameter:
        // select : the DOM node with the class `select` related to the native widget
        function getIndex(select) {
            // We need to access the native widget for the given custom widget
            // In our example, that native widget is a sibling of the custom widget
            var nativeWidget = select.previousElementSibling;

            return nativeWidget.selectedIndex;
        };

        window.addEventListener('load', function() {
            var selectList = document.querySelectorAll('.select');

            selectList[0].addEventListener('mouseover', function() {
                activeSelect(selectList[0], selectList);
            });

            // Each custom widget needs to be initialized
            selectList.forEach(function(select) {
                // as well as all its `option` elements
                var optionList = select.querySelectorAll('.option');
                toggleOptList(select);
                highlightOption(select, optionList[0]);


                // Each time a user hovers their mouse over an option, we highlight the given option
                optionList.forEach(function(option) {
                    option.addEventListener('mousedown', function() {
                        // Note: the `select` and `option` variable are closures
                        // available in the scope of our function call.
                        highlightOption(select, option);
                        updateValue(select, option);
                    });
                });

                // Each times the user click on a custom select element
                select.addEventListener('click', function(event) {
                    // Note: the `select` variable is a closure
                    // available in the scope of our function call.

                    // We toggle the visibility of the list of options
                    toggleOptList(select);
                });

                // In case the widget gain focus
                // The widget gains the focus each time the user clicks on it or each time
                // they use the tabulation key to access the widget
                select.addEventListener('focus', function(event) {
                    // Note: the `select` and `selectList` variable are closures
                    // available in the scope of our function call.

                    // We activate the widget
                    activeSelect(select, selectList);
                });

                // We activate the widget
                activeSelect(select, selectList);
            });

            // In case the widget loses focus
            select.addEventListener('blur', function(event) {
                // Note: the `select` variable is a closure
                // available in the scope of our function call.

                // We deactivate the widget
                deactivateSelect(select);
            });
        });
        
    </script>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="headerPad">
            Report a Bug
        </div>
        <div class="centralPad">
            <table border="0">
                <tr>
                    <td>
                    Bug Title:&nbsp;(Please provide a brief description)
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox runat="server" id="BugTitle" CssClass="title" />
                    </td>
                </tr>
                <tr>
                    <td>
                    Status:
                    </td>
                </tr>
                <tr>
                    <td>
                        <!-- This is our main container for our widget.
                             The tabindex attribute is what allows the user to focus the widget. 
                             We'll see later that it's better to set it through JavaScript. -->
                        <asp:Panel runat="server" CssClass="select">
  
                            <!-- This container will be used to display the current value of the widget -->
                            <asp:Label runat="server" ID="BugStatus" CssClass="value">Cherry</asp:Label>
  
                            <!-- This container will contain all the options available for our widget.
                                 Because it's a list, it makes sense to use the ul element. -->
                            <ul class="optList">
                                <!-- Each option only contains the value to be displayed, we'll see later
                                     how to handle the real value that will be sent with the form data -->
                                <li class="option">Cherry</li>
                                <li class="option">Lemon</li>
                                <li class="option">Banana</li>
                                <li class="option">Strawberry</li>
                                <li class="option">Apple</li>
                            </ul>

                        </asp:Panel>
                        <select>
                            <option selected="selected">Reported</option>
                        </select>
                    </td>
                </tr>
                <tr class="gap" />
                <tr>
                    <td valign="top">Steps to reproduce the bug:&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox TextMode="MultiLine" id="BugDescription" runat="server" CssClass="description" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="CreateBug" runat="server" Text="Save" OnClick="SaveBugInfo" />
                        <asp:Button ID="Cancel" runat="server" Text="Cancel" OnClick="CancelBug" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
