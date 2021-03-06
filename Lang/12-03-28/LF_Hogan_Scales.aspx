<%@ Page Language="VB" Trace="False" MasterPageFile="~/Lang/Lang.master" ValidateRequest="False"
    AutoEventWireup="false" CodeFile="LF_Hogan_Scales.aspx.vb" Inherits="Lang_Dimensions"
    Title="Leaderfit+Hogan Scales" StylesheetTheme="admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [EngScaleName], [EngScaleDesc], [ScaleName], [ScaleDesc], AutoID FROM [Lang_Scales] WHERE ([LanguageID] = @LanguageID) ORDER BY IsHogan, [ScaleName]">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Leaderfit+Hogan Scales</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" Width="750px" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="ScaleName" SortExpression="EngScaleName" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="autoID" runat="server" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EngScaleName") %>'></asp:Label>
                    <asp:TextBox ID="ScaleName" runat="server" Text='<%# Bind("ScaleName") %>' Columns="40"
                        SkinID="1"></asp:TextBox><br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngScaleName")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ScaleDesc" SortExpression="EngScaleDesc" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EngScaleDesc") %>'></asp:Label>
                    <asp:TextBox ID="ScaleDesc" runat="server" Text='<%# Bind("ScaleDesc") %>' TextMode="MultiLine"
                        Rows="4" Columns="60" SkinID="2"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength2" ForeColor="Green" Text='<%# Len(Eval("EngScaleDesc")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft2"></asp:Label></ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
