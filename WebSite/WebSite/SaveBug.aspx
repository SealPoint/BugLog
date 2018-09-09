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
        .customSelect
        {
            /* This will create a positioning context for the list of options */
            position: relative;
 
            /* This will make our widget become part of the text flow and sizable at the same time */
            display: inline-block;
        }
        
        .customSelect.mouseover
        {
            outline: none;
            border: solid 1px #3399FF;
 
            /* This box-shadow property is not exactly required, however it's so important to be sure
            the active state is visible that we use it as a default value, feel free to override it. */
            /*box-shadow: 0 0 3px 1px #227755;*/
        }
        
        /* The .select selector here is syntactic sugar to be sure the classes we define are
           the ones inside our widget. */
        .customSelect .optList
        {
            /* This will make sure our list of options will be displayed below the value
               and out of the HTML flow */
            position: absolute;
            top: 100%;
            left: 0;
        }
        
        .customSelect .optList.hidden
        {
            /* This is a simple way to hide the list in an accessible way, 
               we will talk more about accessibility in the end */
            max-height: 0;
            visibility: hidden;
        }
        
        .customSelect
        {
            display: inline-block;
            -moz-box-sizing: border-box;
            box-sizing: content-box;

            /* We need extra room for the down arrow we will add */
            padding: 0 0 0 0;
            width: 120px;
            height: 20px;
            border: solid 1px #707070;
        }
        
        .value
        {
            /* Because the value can be wider than our widget, we have to make sure it will not
               change the widget's width */
            z-index: 1;
            position: absolute;
            display: block;
            top: 0;
            left: -0.5px;
            height: 18px;
            width: 98px;
            overflow: hidden;
            padding: 0 0 0 0;
            font-family: Calibri;
            font-size: 11.5pt;
            padding-left: 2px;
            padding-bottom: 0;

            line-height: 17px;

            /* And if the content overflows, it's better to have a nice ellipsis. */
            white-space: nowrap;
            text-overflow: ellipsis;
            background: #FFFFFF;
            border-top: solid 1px #C0C0C0;
            border-left: solid 1px #C0C0C0;
            border-bottom: solid 1px #C0C0C0;
        }
        
        .customSelect:after
        {
            content: ">"; /* We use the unicode caracter U+25BC; see http://www.utf8-chartable.de */
            font: bold 20px "Consolas", monospace;
            transform: rotate(90deg);
            position: absolute;
            z-index: 1; /* This will be important to keep the arrow from overlapping the list of options */
            top: -0.5px;
            right: 0;
            line-height: 18px;
            padding-left: 3px;

            -moz-box-sizing: border-box;
            box-sizing: content-box;

            height: 20px;
            width: 16px;  /* 20px */
            text-align: middle;

            /*border-left: .2em solid #000; 2px */

            /* The first declaration is for browsers that do not support linear gradients.
               The second declaration is because WebKit based browsers haven't unprefixed it yet.
               If you want to support legacy browsers, try http://www.colorzilla.com/gradient-editor/ */
            background: #D0D0D0;
            /*background: -webkit-linear-gradient(90deg, #E3E3E3, #fcfcfc);
            background: linear-gradient(270deg, #C0C0C0, #fcfcfc);*/
        }
        
        .customSelect .optList
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

            border: 1px solid #000; /* 2px */
            border-top-width : .1em; /* 1px */

            box-shadow: 0 .2em .4em rgba(0,0,0,.4); /* 0 2px 4px */
            background: #f0f0f0;
        }
        
        .customSelect .redOption
        {
            padding: 2px 3px;
            background: #FF5050;
        }
        
        .customSelect .yellowOption
        {
            padding: 2px 3px;
            background: #FFFF66;
        }
        
        .customSelect .greenOption
        {
            padding: 2px 3px;
            background: #66FF66;
        }

        .customSelect .highlight
        {
            background: #000;
            color: #FFFFFF;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var selectedIndex = 0;
        NodeList.prototype.forEach = function(callback)
        {
            Array.prototype.forEach.call(this, callback);
        }

        // This function will be used each time we want to deactivate a custom widget
        // It takes one parameter
        // select : the DOM node with the `select` class to deactivate
        function deactivateSelect(select) {
            var optList = select.querySelector('.optList');

            if (!optList.classList.contains("hidden")) {
                optList.classList.add("hidden");
            }
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
            selectList.forEach(deactivateSelect);

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
            value.style.backgroundColor = window.getComputedStyle(option, null).getPropertyValue('background-color')
        };
        
        function addOptionSelectionListener(select, colorOptionClass)
        {
            var optionList = select.querySelectorAll(colorOptionClass);

            // Each time a user hovers their mouse over an option, we highlight the given option
            optionList.forEach(function(option) {
                option.addEventListener('mousedown', function() {
                    // Note: the `select` and `option` variable are closures
                    // available in the scope of our function call.
                    updateValue(select, option);
                });
            });
                
        };

        window.addEventListener('load', function() {

            var selectList = document.querySelectorAll('.customSelect');

            // Each custom widget needs to be initialized
            selectList.forEach(function(select) {
                addOptionSelectionListener(select, ".redOption");
                addOptionSelectionListener(select, ".yellowOption");
                addOptionSelectionListener(select, ".greenOption");

                // Each times the user click on a custom select element
                select.addEventListener('mouseenter', function(event) {
                    select.classList.add("mouseover");
                });

                // Each times the user click on a custom select element
                select.addEventListener('mouseleave', function(event) {
                    select.classList.remove("mouseover");
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

                // In case the widget loses focus
                select.addEventListener('blur', function(event) {
                    // Note: the `select` variable is a closure
                    // available in the scope of our function call.

                    // We deactivate the widget
                    deactivateSelect(select);
                });

                toggleOptList(select);
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
                        <asp:TextBox runat="server" id="BugTitle" CssClass="title"/>
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
                        <asp:Panel runat="server" CssClass="customSelect">
  
                            <!-- This container will be used to display the current value of the widget -->
                            <asp:Label runat="server" ID="BugStatus" CssClass="value"></asp:Label>
  
                            <!-- This container will contain all the options available for our widget.
                                 Because it's a list, it makes sense to use the ul element. -->
                            <ul id="StatusOptions" runat="server" class="optList">
                                <!-- Each option only contains the value to be displayed, we'll see later
                                     how to handle the real value that will be sent with the form data -->
                                <li runat="server" class="redOption">Reported</li>
                                <li runat="server" class="yellowOption">In Progress</li>
                                <li runat="server" class="greenOption">Fixed</li>
                            </ul>

                        </asp:Panel>
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
