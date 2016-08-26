<%@ Page Language="VB" Trace="false" Debug="false" MasterPageFile="~/Lang/Lang.master"
    ValidateRequest="False" AutoEventWireup="false" CodeFile="LFStatic.aspx.vb"
    Inherits="Lang_Dimensions" Title="Leaderfit Static Text" StylesheetTheme="admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [EngScaleName], [ScaleName], HoganComps, IsNull(EngHoganComps, '') as EngHoganComps, IsNull(LFBullets, '') as LFBullets, IsNull(EngLFBullets, '') as EngLFBullets, AutoID FROM [Lang_Scales] WHERE ([LanguageID] = @LanguageID) and IsHogan=0 ORDER BY ScaleID">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Leaderfit Scales Static Text</div>
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
                    
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Hogan Competencies" SortExpression="EngHoganComps"
                ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="EngHoganComps" runat="server" Text='<%# Bind("EngHoganComps") %>'></asp:Label>
                    <asp:TextBox ID="HoganComps" runat="server" Text='<%# Bind("HoganComps") %>' TextMode="MultiLine"
                        Rows="4" Columns="30" SkinID="3"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength3" ForeColor="Green" Text='<%# Len(Eval("EngHoganComps")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft3"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bullets" SortExpression="EngLFBullets" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="EngLFBullets" runat="server" Text='<%# Replace(Eval("EngLFBullets"), Chr(13) & Chr(10), "<br>") %>'></asp:Label>
                    <asp:TextBox ID="LFBullets" runat="server" Text='<%# Bind("LFBullets") %>' TextMode="MultiLine"
                        Rows="6" Columns="70" SkinID="4"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength4" ForeColor="Green" Text='<%# Len(Eval("EngLFBullets")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft4"></asp:Label></ItemTemplate>

                    <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <HeaderTemplate><b>Bullets</b><br />
                <small>Note: Please enter each entry on a separate line as shown in the English text</small>
                </HeaderTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
