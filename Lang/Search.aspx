<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/Lang/Lang.master" Title="Search"
    CodeFile="Search.aspx.vb" Inherits="Lang_Search" StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td>
                Search:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtSearch"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnSearch" Text="Search" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource runat="server" ID="rsA" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="Lang_DoSearch" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" DefaultValue="1" Name="LanguageID" Type="Int32" />
            <asp:ControlParameter ControlID="txtSearch" Name="search" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView runat="server" ID="tabA" DataSourceID="rsA" AutoGenerateColumns="false" EmptyDataText="No matches found."
        HeaderStyle-CssClass="headrow" CellPadding="3" CellSpacing="0" ShowHeader="true"
        GridLines="Both">
        <Columns>
            <asp:HyperLinkField DataTextField="PageName" DataNavigateUrlFields="PageName" Target="sub1"
                HeaderText="Page Name" />
            <asp:BoundField DataField="KeyName" HeaderText="Key Name" />
        </Columns>
    </asp:GridView>
</asp:Content>
