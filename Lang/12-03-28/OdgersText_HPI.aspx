<%@ Page Language="VB" Trace="false" Debug="false" ValidateRequest="False" MasterPageFile="~/Lang/Lang.master"
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
                        <asp:Label runat="server" ID="EngOverview1"  Text='<%# Eval("EngOverview1") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Overview1"
                            Text='<%# Bind("Overview1") %>' SkinID="1"></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngOverview1")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <%--<asp:Label runat="server" ID="charsleft1" ForeColor="Red"></asp:Label>&nbsp &nbsp;--%>
                        <span id=charsleft1></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Overview (Alt): </b>
                        <asp:Label runat="server" ID="EngOverview2" Text='<%# Eval("EngOverview2") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Overview2"
                            Text='<%# Bind("Overview2") %>' SkinID="2"></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength2" ForeColor="Green" Text='<%# Len(Eval("EngOverview2")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft2></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Strengths: </b>
                        <asp:Label runat="server" ID="EngStrengths" Text='<%# Eval("EngStrengths") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Strengths"
                            Text='<%# Bind("Strengths") %>'  SkinID=3></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength3" ForeColor="Green" Text='<%# Len(Eval("EngStrengths")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft3></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Gaps: </b>
                        <asp:Label runat="server" ID="EngGaps" Text='<%# Eval("EngGaps") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="Gaps"
                            Text='<%# Bind("Gaps") %>'  SkinID=4></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength4" ForeColor="Green" Text='<%# Len(Eval("EngGaps")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft4></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Execution: </b>
                        <asp:Label runat="server" ID="EngLF1" Text='<%# Eval("EngLF1") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF1"
                            Text='<%# Bind("LF1") %>'  SkinID=5></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength5" ForeColor="Green" Text='<%# Len(Eval("EngLF1")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft5></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Strategic: </b>
                        <asp:Label runat="server" ID="EnglF2" Text='<%# Eval("EngLF2") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF2"
                            Text='<%# Bind("LF2") %>'  SkinID=6></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength6" ForeColor="Green" Text='<%# Len(Eval("EngLF2")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft6></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_SelfImage: </b>
                        <asp:Label runat="server" ID="EngLF3" Text='<%# Eval("EngLF3") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="MultiLine" Rows="10" Columns="50" runat="server" ID="Lf3"
                            Text='<%# Bind("LF3") %>'  SkinID=7></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength7" ForeColor="Green" Text='<%# Len(Eval("EngLF3")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft7></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Relationship: </b>
                        <asp:Label runat="server" ID="EngLF4" Text='<%# Eval("EngLF4") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF4"
                            Text='<%# Bind("LF4") %>'  SkinID=8></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength8" ForeColor="Green" Text='<%# Len(Eval("EngLF4")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft8></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Analysis_Team: </b>
                        <asp:Label runat="server" ID="EngLF5" Text='<%# Eval("EngLF5") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="LF5"
                            Text='<%# Bind("LF5") %>'  SkinID=9></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength9" ForeColor="Green" Text='<%# Len(Eval("EngLF5")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft9></span>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Career Development: </b>
                        <asp:Label runat="server" ID="EngCareerDevtext" Text='<%# Eval("EngCareerDevtext") %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="CareerDevtext"
                            Text='<%# Bind("CareerDevtext") %>' SkinID=10></asp:TextBox><br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength10" ForeColor="Green" Text='<%# Len(Eval("EngCareerDevtext")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <span id=charsleft10></span>
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
