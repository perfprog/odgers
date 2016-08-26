<%@ Page Language="VB" Trace="False" MasterPageFile="~/Lang/Lang.master" ValidateRequest="False"
    AutoEventWireup="false" CodeFile="HoganSubscales_HDS.aspx.vb" Inherits="Lang_HoganScales"
    Title="Hogan *HDS* Subscales" StylesheetTheme="admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [EngsubScaleName], [SubscaleName], AutoID FROM [Lang_HoganSubscales_HDS] WHERE ([LanguageID] = @LanguageID) ORDER BY subscalename">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Hogan Subscales (HDS)</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="SubscaleName" SortExpression="EngsubScaleName" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="autoID" runat="server" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EngSubScaleName") %>'></asp:Label>
                    <br />
                    <asp:TextBox ID="SubscaleName" runat="server" Text='<%# Bind("SubscaleName") %>'
                        Width="300" SkinID=1></asp:TextBox><br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngSubScaleName")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat=server ID="charsleft1"></asp:Label>

                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
