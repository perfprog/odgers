<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PageBanner.ascx.vb" Inherits="Controls_PageBanner" %>
<style>
    .pagebanner {
        border: 1px solid black;
        text-align: center;
        background-color: lightgoldenrodyellow;
        color: red;
        font-size: 18px;
        display:block;
    }
</style>
<p visible="true" runat="server" id="parBanner" class="pagebanner">
    <asp:Label ID="lblBanner" runat="server"></asp:Label>
</p>
