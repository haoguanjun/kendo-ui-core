﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="demo-section one-way">
        <div class="list-wrapper">
            <ul id="sortable-listA">
                <li class="list-item">Apples</li>
                <li class="list-item">Grapefruits</li>
                <li class="list-item">Bananas</li>
            </ul>
    
            <ul id="sortable-listB">
                <li class="list-item">Cranberries</li>
                <li class="list-item">Pineapples</li>
                <li class="list-item">Strawberries</li>
            </ul>
        </div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listA")
        .ConnectWith("#sortable-listB")
        .PlaceholderHandler("placeholder")
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listB")
        .PlaceholderHandler("placeholder")
    %>

    <div class="demo-section two-way">
        <div class="list-wrapper">
            <ul id="sortable-listC" style="min-height: 41px;">
                <li class="list-item">Cherries</li>
                <li class="list-item">Pears</li>
                <li class="list-item">Plums</li>
            </ul>
    
            <ul id="sortable-listD" style="min-height: 41px;">
                <li class="list-item">Apricots</li>
                <li class="list-item">Grapes</li>
                <li class="list-item">Lemons</li>
            </ul>
        </div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listC")
        .ConnectWith("#sortable-listD")
        .PlaceholderHandler("placeholder")
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listD")
        .ConnectWith("#sortable-listC")
        .PlaceholderHandler("placeholder")
    %>

    <script>
        function placeholder(element) {
            return $("<li class='list-item' id='placeholder'>Drop Here!</li>");
        }
    </script>

    <style>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .demo-section {
            padding: 50px 70px;
        }

        .one-way {
            background: url('<%=Url.Content("~/content/web/sortable/one-way.png")%>') no-repeat 50% 50%;
        }

        .two-way {
            background: url('<%=Url.Content("~/content/web/sortable/two-way.png")%>') no-repeat 50% 50%;
        }

        .list-wrapper {
            overflow: hidden;
        }

        #sortable-listA, #sortable-listB, #sortable-listC, #sortable-listD {
            width: 210px;
            min-height: 40px;
            margin: 0;
            padding: 0;
            border: 1px solid #dddddd;
            border-radius: 4px;
        }

        #sortable-listA, #sortable-listC {
            float: left;
        }

        #sortable-listB, #sortable-listD {
            float: right;
        }

        .list-item {
            list-style-type: none;
            width: 200px;
            margin: 5px;
            line-height: 30px;
            text-align: center;
            background-color: #222222;
            color: #ffffff;
            border-radius: 3px;
        }

        #sortable-listA .list-item {
            background-color: #54b8fa;
            color: #000000;
        }

        #sortable-listB .list-item {
            background-color: #ff879e;
            color: #000000;
        }

        #sortable-listC .list-item {
            background-color: #66cc66;
            color: #000000;
        }

        #sortable-listD .list-item {
            background-color: #ffcc33;
            color: #000000;
        }

        #placeholder.list-item {
            background-color: #ffffff;
            color: #777;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>