<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/Lang/Lang.master"
    AutoEventWireup="false" CodeFile="ReportText.aspx.vb" Inherits="Lang_ReportText" Title="Report Labels"
    StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [AutoID], [KeyName], [KeyValue], [EngKeyValue] FROM [Lang_ReportText] WHERE ([LanguageID] = @LanguageID) ORDER BY [KeyName]">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" DefaultValue="1" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Report Labels</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" Width="750px" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="KeyName" ItemStyle-VerticalAlign="Top">
                <ItemTemplate>
                    <asp:Label ID="KeyName" runat="server" Text='<%# Eval("KeyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="KeyValue" ItemStyle-VerticalAlign="Bottom">
            <itemtemplate>
                <asp:Label ID="autoID" runat="server" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EngKeyValue") %>'></asp:Label>
                    <br /><asp:TextBox ID="KeyValue" runat="server" Text='<%# Bind("KeyValue") %>' Columns="60"
                        Rows="3" TextMode="MultiLine" SkinID=1></asp:TextBox>
                        <br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngKeyValue")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat=server ID="charsleft1"></asp:Label>
                </itemtemplate>
            <footertemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </footertemplate>
            <footerstyle horizontalalign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
