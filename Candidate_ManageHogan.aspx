<%@ Page Title="Manage Candidate Assessments and Reports" Trace="false" Debug="false"
    Language="VB" MasterPageFile="~/admin.master" AutoEventWireup="false" StylesheetTheme="Admin"
    CodeFile="Candidate_ManageHogan.aspx.vb" Inherits="CandidateScores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [HoganUserName], [HoganUserPassword], [AssgnTypeID], [AssgnTypeName], [AssgnDesc], [CandidateID], [CandidateName], [FirstName], [LastName], [DateLFGenerated], [ReportList], [OfficeID], [officeName], [AssgnID], [LanguageID], HoganAssessList, HoganRptList, AddAssmts, AddRpts FROM [qryAssgnCandidates] WHERE ([CandidateID] = @CandidateID) ORDER BY [AssgnDesc]">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" DefaultValue="1"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellpadding="4" cellspacing="0" border="1">
        <tr class="Section">
            <td>
                Candidate Info
            </td>
            <td>
                Assignments
            </td>
            <td>
                Reports
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:FormView ID="frmCan" runat="server" DataKeyNames="CandidateID" DataSourceID="rsCan"
                    EnableModelValidation="True">
                    <ItemTemplate>
                        <table cellspacing="0" cellpadding="3" border="0">
                            <tr>
                                <td>
                                    <b>Candidate ID:</b>
                                </td>
                                <td>
                                    <asp:Label ID="CandidateID" runat="server" Text='<%# Eval("CandidateID") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>FirstName:</b>
                                </td>
                                <td>
                                    <asp:Label ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>LastName:</b>
                                </td>
                                <td>
                                    <asp:Label ID="LastName" runat="server" Text='<%# Bind("LastName") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Hogan Code:</b>
                                </td>
                                <td>
                                    <asp:Label ID="HoganUserName" runat="server" Text='<%# Bind("HoganUserName") %>' />
                                    /
                                    <asp:Label ID="HoganUserPassword" runat="server" Text='<%# Bind("HoganUserPassword") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td valign="top">
                <asp:GridView runat="server" ID="tabCan" DataSourceID="rscan" AutoGenerateColumns="false"
                    HeaderStyle-CssClass="headrow" AlternatingRowStyle-CssClass="altrow" CellPadding="4"
                    CellSpacing="0" GridLines="Both">
                    <Columns>
                        <asp:BoundField DataField="OfficeName" HeaderText="Office Name" />
                        <asp:BoundField DataField="AssgnDesc" HeaderText="Assgn. Name" />
                        <asp:BoundField DataField="AssgnTypeName" HeaderText="Assgn. Type" />
                    </Columns>
                </asp:GridView>
            </td>
            <td valign="top">
                <table runat="server" id="rptList">
                </table>
            </td>
        </tr>
    </table>
    <br />
    <div class=note style="width:700px;">
    <ol>
    <li>Entries that are checked have already been requested. So, they cannot be un-requested. </li>
    <li>Default Hogan Assessment and Report selections are shown in grey. </li>
    <li>Assessments and Reports added manually are shown in green. </li></ol>
    </div>
    <br />
    <table cellpadding="4" cellspacing="0" border="1">
        <tr class="Section">
            <td>
                Add Reports
            </td>
            <td>
                Add Assessments
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:SqlDataSource runat="server" ID="rsRpts" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [ReportTypeID], [ReportTypeName], [LangInits], AssmtsList FROM [ReportTypes] ORDER BY [ReportTypeName]">
                </asp:SqlDataSource>
                <asp:GridView runat="server" ID="tabRpts" GridLines="None" BorderColor="Navy" BorderStyle="Solid"
                    HeaderStyle-CssClass="headrow" AlternatingRowStyle-CssClass="altrow" CellPadding="3"
                    CellSpacing="0" BorderWidth="1" DataSourceID="rsRpts" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Report Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="ReportTypeID" Text='<%# Eval("ReportTypeID") %>' Visible="false"></asp:Label>
                                <asp:Label runat="server" ID="AssmtsList" Text='<%# Eval("AssmtsList") %>' Visible="false"></asp:Label>
                                <asp:CheckBox runat="server" ID="DoSelect" Text='<%# Eval("ReportTypeName") %>' />
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Report Language">
                            <ItemTemplate>
                                <asp:RadioButtonList runat="server" ID="HoganLangs" RepeatDirection="Vertical" RepeatColumns="3">
                                </asp:RadioButtonList>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Button runat="server" ID="btnAddRpts" Text="1. Add Reports" />
                &nbsp; &nbsp;
                <asp:Button runat="server" ID="btnUpdateHogan" Text="2. Update Hogan Portal" />
            </td>
            <td valign="top">
                <asp:CheckBoxList runat="server" ID="AddAssmts">
                    <asp:ListItem Text="HPI" Value="HPI"></asp:ListItem>
                    <asp:ListItem Text="HDS" Value="HDS"></asp:ListItem>
                    <asp:ListItem Text="MVPI" Value="MVPI"></asp:ListItem>
                    <asp:ListItem Text="HBRI" Value="HBRI"></asp:ListItem>
                </asp:CheckBoxList>
                <br />
                <asp:Button runat="server" ID="btnAddAssmts" Text="Add Assessments" />
            </td>
        </tr>
    </table>
</asp:Content>
