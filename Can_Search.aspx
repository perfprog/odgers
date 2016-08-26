<%@ Page Title="Search Participants" Language="VB" MasterPageFile="Admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="Can_Search.aspx.vb"
    Inherits="Admin_Parts_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Heading1">
        Search Candidates</div>
    <div id="divSearch">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td valign="top">
                    <b>Last Name: </b>
                </td>
                <td valign="top">
                    <asp:TextBox runat="server" ID="LastName" Width="200"></asp:TextBox>
                </td>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnSearch" Text="Search" />
                        <br />
                        <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="rsP" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [FirstName], [LastName], [AssgnDesc], [DateEntered], [AssgnID], [OfficeName], OfficeID FROM [qryCan_Search] WHERE (OfficeID=@OfficeID AND [Active] = 1 or @OfficeID=999 AND [Active] = 1 or @PPIOfficeID=1000) and ([LastName] LIKE '%' + @LastName + '%') ORDER BY [LastName], [FirstName], [AssgnDesc]">
        <SelectParameters>
            <asp:ControlParameter ControlID="LastName" Name="LastName" PropertyName="Text" Type="String" />
            <asp:CookieParameter Name="OfficeId" CookieName="OfficeID" Type="String" />
            <asp:CookieParameter CookieName="PPIOfficeID" Name="PPIOfficeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="tabP" runat="server" DataSourceID="rsP" CellPadding="5" HeaderStyle-CssClass="headrow"
        FooterStyle-CssClass="footrow" AlternatingRowStyle-CssClass="altrow" SelectedRowStyle-CssClass="selrow"
        EditRowStyle-CssClass="selrow" AllowSorting="True" AutoGenerateColumns="False"
        EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName">
            </asp:BoundField>
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName">
            </asp:BoundField>
            <asp:TemplateField HeaderText="Assignment Name">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="AssgnDesc" Text='<%# Eval("AssgnDesc") %>' NavigateUrl='<%# "Assignments.aspx?AssgnID=" & Eval("AssgnID") & "&OfficeID=" & Eval("OfficeID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DateEntered" HeaderText="DateEntered" SortExpression="DateEntered" />
            <asp:BoundField DataField="OfficeName" HeaderText="OfficeName" SortExpression="OfficeName" />
        </Columns>
        <EditRowStyle CssClass="selrow"></EditRowStyle>
        <FooterStyle CssClass="footrow" />
        <SelectedRowStyle CssClass="selrow" />
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
    </asp:GridView>
</asp:Content>
