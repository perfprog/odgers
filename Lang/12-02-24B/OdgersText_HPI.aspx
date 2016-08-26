<%@ Page Language="VB" Trace="False" Debug="False" ValidateRequest="False" MasterPageFile="~/Lang/Lang.master"
    AutoEventWireup="false" CodeFile="OdgersText_HPI.aspx.vb" Inherits="Lang_OdgersText_HPI"
    Title="Odgers HPI Text" StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsScale" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT ScaleID, [ScaleName] FROM [HoganScales] WHERE ([LanguageID] = 1) and ScaleType='HPI' ORDER BY [ScaleName]">
    </asp:SqlDataSource>
    <div class="Section">
        Odgers HPI Text</div>
    <br />
    <table>
        <tr>
            <td valign="top">
                Scale:
            </td>
            <td valign="top">
                <asp:DropDownList runat="server" ID="ScaleID" DataSourceID="rsScale" DataTextField="ScaleName"
                    DataValueField="ScaleID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Level:
            </td>
            <td valign="top">
                <asp:DropDownList runat="server" ID="Levelname">
                    <asp:ListItem Text="Low" Value="low"></asp:ListItem>
                    <asp:ListItem Text="Middle" Value="med"></asp:ListItem>
                    <asp:ListItem Text="High" Value="high"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td valign="top">
            </td>
            <td valign="top">
                <asp:Button runat="server" ID="btnGet" Text="Get Data" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [Overview1], [Strengths], [Overview2],  [Gaps], [LF1], [LF2], [LF3], [LF4], [LF5], [AutoID], [EngOverview1], [EngStrengths], [EngOverview2], [EngGaps], [EngLF1], [EngLF2], [EngLF3], [EngLF4], [EngLF5], [LanguageID], [ScaleID], [LevelName], CareerDevText, EngCareerDevText FROM [Lang_OdgersText_HPI] WHERE (([LanguageID] = @LanguageID) AND ([ScaleID] = @ScaleID) AND ([LevelName] = @LevelName))">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Int16" />
            <asp:ControlParameter ControlID="ScaleID" Name="ScaleID" PropertyName="SelectedValue"
                Type="Int16" />
            <asp:ControlParameter ControlID="Levelname" Name="LevelName" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table border="1" cellpadding="3" cellspacing="0">
        <asp:Repeater ID="tabA" runat="server" DataSourceID="rsA">
            <ItemTemplate>
                <tr>
                    <td valign="top">
                        <asp:Label runat="server" ID="AutoID" Text='<%# Eval("AutoID") %>' Visible="false"></asp:Label>
                        <b>Overview: </b>
                        <asp:Label runat="server" ID="EngOverview1" Text='<%# Eval("EngOverview1") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Overview1"
                            Text='<%# Bind("Overview1") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Overview (Alt): </b>
                        <asp:Label runat="server" ID="EngOverview2" Text='<%# Eval("EngOverview2") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Overview2"
                            Text='<%# Bind("Overview2") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Strengths: </b>
                        <asp:Label runat="server" ID="EngStrengths" Text='<%# Eval("EngStrengths") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Strengths"
                            Text='<%# Bind("Strengths") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Gaps: </b>
                        <asp:Label runat="server" ID="EngGaps" Text='<%# Eval("EngGaps") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Gaps"
                            Text='<%# Bind("Gaps") %>'></asp:TextBox>
                    </td>
                </tr>
                <%--<tr>
                    <td valign=top>
                        <b>Bullets: </b>
                        <asp:Label runat="server" ID="EngBullets" Text='<%# Eval("EngBullets") %>'></asp:Label></td>
                    <td valign=top>
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Bullets"
                            Text='<%# Bind("Bullets") %>'></asp:TextBox></td>
                </tr>--%>
                <tr>
                    <td valign="top">
                        <b>Analysis_Execution: </b>
                        <asp:Label runat="server" ID="EngLF1" Text='<%# Eval("EngLF1") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF1"
                            Text='<%# Bind("LF1") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Strategic: </b>
                        <asp:Label runat="server" ID="EnglF2" Text='<%# Eval("EngLF2") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF2"
                            Text='<%# Bind("LF2") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_SelfImage: </b>
                        <asp:Label runat="server" ID="EngLF3" Text='<%# Eval("EngLF3") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="MultiLine" Rows="10" Columns="50" runat="server" ID="Lf3"
                            Text='<%# Bind("LF3") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Relationship: </b>
                        <asp:Label runat="server" ID="EngLF4" Text='<%# Eval("EngLF4") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF4"
                            Text='<%# Bind("LF4") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Team: </b>
                        <asp:Label runat="server" ID="EngLF5" Text='<%# Eval("EngLF5") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF5"
                            Text='<%# Bind("LF5") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Career Development: </b>
                        <asp:Label runat="server" ID="EngCareerDevtext" Text='<%# Eval("EngCareerDevtext") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="CareerDevtext"
                            Text='<%# Bind("CareerDevtext") %>'></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>
                        <td align="right">
                            <asp:Button runat="server" ID="btnSave" Text="Save" CommandName="Save1" />
                        </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
