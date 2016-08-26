<%@ Page Language="VB" Trace="false" Debug="false" MasterPageFile="~/Admin.master"
    AutoEventWireup="false" CodeFile="Assignments.aspx.vb" Inherits="Assignments"
    Title="Assignments" StylesheetTheme="Admin" %>

<%@ Register TagPrefix="BDP" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table>
            <tr>
                <td class="Heading1">
                    Manage Assignments
                </td>
                <td width="160" align="right">
                    filter by:
                </td>
                <td>
                    <a href="javascript:filter('a');">A</a> <a href="javascript:filter('b');">B</a>
                    <a href="javascript:filter('c');">C</a> <a href="javascript:filter('d');">D</a>
                    <a href="javascript:filter('e');">E</a> <a href="javascript:filter('f');">F</a>
                    <a href="javascript:filter('g');">G</a> <a href="javascript:filter('h');">H</a>
                    <a href="javascript:filter('i');">I</a> <a href="javascript:filter('J');">J</a>
                    <a href="javascript:filter('K');">K</a> <a href="javascript:filter('L');">L</a>
                    <a href="javascript:filter('M');">M</a> <a href="javascript:filter('N');">N</a>
                    <a href="javascript:filter('O');">O</a> <a href="javascript:filter('P');">P</a>
                    <a href="javascript:filter('Q');">Q</a> <a href="javascript:filter('R');">R</a>
                    <a href="javascript:filter('S');">S</a> <a href="javascript:filter('T');">T</a>
                    <a href="javascript:filter('U');">U</a> <a href="javascript:filter('V');">V</a>
                    <a href="javascript:filter('W');">W</a> <a href="javascript:filter('X');">X</a>
                    <a href="javascript:filter('Y');">Y</a> <a href="javascript:filter('Z');">Z</a>
                </td>
                <td width="100" align="right">
                    <a href="javascript: filter(' ');">show all</a>
                </td>
            </tr>
        </table>
        <asp:TextBox runat="server" ID="StartsWith" Style="display: none;"></asp:TextBox>
    </div>
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label>
    <br />
    <table width="100%" border="0">
        <tr>
            <td valign="top">
                <asp:SqlDataSource ID="rsOffices" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [OfficeID], [OfficeName] FROM [Offices] WHERE ([OfficeID] = @OfficeID AND [Active] = 1 or @OfficeID=999 AND [Active] = 1 or @PPIOfficeID=1000) ORDER BY [OfficeName]">
                    <SelectParameters>
                        <asp:CookieParameter CookieName="OfficeID" Name="OfficeID" Type="Int32" />
                        <asp:CookieParameter CookieName="PPIOfficeID" Name="PPIOfficeID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                Select Office:
                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                    DataValueField="OfficeID" AutoPostBack="True">
                </asp:DropDownList>
                <br />
                <br />
                <asp:SqlDataSource ID="rsList" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT AssgnID, ProjectRefNo, AssgnTypeID, AssgnTypeName, StatusOrder, DateEntered, ClientName, AssgnDesc, IsNull(ClientName, '')+IsNull(AssgnDesc, '') as ClientSort FROM qryAssgnList where ((@OfficeID<999 and OfficeID=@OfficeID) or (@OfficeID=999)) and ((ClientName Like  @StartsWith + '%') or @StartsWith =' ' ) order by ProjectRefNo, AssgnTypeID, AssgnID Desc">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="StartsWith" DefaultValue=" " Name="StartsWith" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="rsLang" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="OfficeLangs_Get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="SelectedValue"
                            Type="Int16" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="tabList" runat="server" DataSourceID="rsList" AutoGenerateColumns="False"
                    HeaderStyle-CssClass="headrow" SelectedRowStyle-CssClass="selrow" CellPadding="4"
                    AllowPaging="True" AllowSorting="True" DataKeyNames="AssgnID" EmptyDataText="There are no assignments at this time."
                    PageSize="20" EnableModelValidation="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Client Name" SortExpression="ClientSort">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="ClientName" CausesValidation="False" Text='<%# Eval("ClientName") %>'
                                    CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="assgnDesc" HeaderText="Assgn. Title" SortExpression="AssgnDesc" />
                        <asp:BoundField DataField="ProjectRefNo" HeaderText="Project Ref. No." SortExpression="ProjectRefNo" />
                        <asp:BoundField DataField="AssgnTypeName" HeaderText="Type" SortExpression="AssgnTypeID" />
                        <asp:BoundField DataField="DateEntered" HeaderText="Date" SortExpression="DateEntered"
                            HtmlEncode="False" DataFormatString="{0:d}" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Button runat="server" ID="btnNew" Text="New Assignment" CausesValidation="false" />
            </td>
            <td width="10">
                &nbsp;
            </td>
            <td valign="top">
                <asp:SqlDataSource ID="rsDetail" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    DeleteCommand="DELETE FROM [Assignments] WHERE [AssgnID] = @AssgnID" InsertCommand="INSERT INTO [Assignments] ([ClientName], [OfficeID], [AssgnTypeID], [AssgnDesc], [AssgnStatus], ProjectRefNo, [Comments], PartnerName, BillingInfo, AdminEmailAddress) VALUES (@ClientName, @OfficeID, @AssgnTypeID, @AssgnDesc, @AssgnStatus, @ProjectRefNo, @Comments, @PartnerName, @BillingInfo, @AdminEmailAddress)"
                    SelectCommand="SELECT [AssgnID], [ClientName], [OfficeID],  [AssgnTypeID],  [AssgnDesc], [AssgnStatus], [ProjectRefNo], [Comments], PartnerName, BillingInfo, AdminEmailAddress FROM [Assignments] WHERE ([AssgnID] = @AssgnID)"
                    UpdateCommand="UPDATE [Assignments] SET [ClientName] = @ClientName, [OfficeID] = @OfficeID, [AssgnTypeID] = @AssgnTypeID, [AssgnDesc] = @AssgnDesc, [AssgnStatus] = @AssgnStatus, [ProjectRefNo] = @ProjectRefNo, [Comments] = @Comments, [PartnerName] = @PartnerName, [BillingInfo] = @BillingInfo, AdminEmailAddress=@AdminEmailAddress WHERE [AssgnID] = @AssgnID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tabList" Name="AssgnID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="AssgnID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ClientName" Type="String" />
                        <asp:Parameter Name="OfficeID" Type="Int32" />
                        <asp:Parameter Name="AssgnTypeID" Type="Int16" />
                        <asp:Parameter Name="AssgnDesc" Type="String" />
                        <asp:Parameter Name="AssgnStatus" Type="String" />
                        <asp:Parameter Name="ProjectRefNo" Type="String" />
                        <asp:Parameter Name="Comments" Type="String" />
                        <asp:Parameter Name="PartnerName" Type="String" />
                        <asp:Parameter Name="BillingInfo" Type="String" />
                        <asp:Parameter Name="AdminEmailAddress" Type="String" />
                        <asp:Parameter Name="AssgnID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ClientName" Type="String" />
                        <asp:Parameter Name="OfficeID" Type="Int32" />
                        <asp:Parameter Name="AssgnTypeID" Type="Int16" />
                        <asp:Parameter Name="AssgnDesc" Type="String" />
                        <asp:Parameter Name="AssgnStatus" Type="String" />
                        <asp:Parameter Name="ProjectRefNo" Type="String" />
                        <asp:Parameter Name="Comments" Type="String" />
                        <asp:Parameter Name="PartnerName" Type="String" />
                        <asp:Parameter Name="BillingInfo" Type="String" />
                        <asp:Parameter Name="AdminEmailAddress" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="rsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="OfficeAssgnTypes_Get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="SelectedValue"
                            Type="Int16" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="rsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [AssgnStatus] FROM [AssgnStatuses] ORDER BY [SortOrder]">
                </asp:SqlDataSource>
                <asp:DetailsView ID="tabDetail" runat="server" DataSourceID="rsDetail" Visible="True"
                    CellPadding="4" HeaderStyle-CssClass="headrow" BackColor="#FFCC99" DefaultMode="Edit"
                    AutoGenerateRows="False" DataKeyNames="AssgnID">
                    <Fields>
                        <asp:BoundField DataField="AssgnID" HeaderText="Assgn. ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="AssgnID" />
                        <asp:TemplateField HeaderText="Client Name" SortExpression="ClientName">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="ClientName" Text='<%# Bind("ClientName") %>' Width="300"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="ClientName" Text='<%# Bind("ClientName") %>' Width="300"></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assgn. Title" SortExpression="AssgnDesc">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="AssgnDesc" Text='<%# Bind("AssgnDesc") %>' Width="300"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="AssgnDesc" Text='<%# Bind("AssgnDesc") %>' Width="300"></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Office ID" SortExpression="OfficeID">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                                    DataValueField="OfficeID" SelectedValue='<%# Bind("OfficeID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                                    DataValueField="OfficeID" SelectedValue='<%# Bind("OfficeID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                                    DataValueField="OfficeID" SelectedValue='<%# Bind("OfficeID") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Report Type" SortExpression="AssgnTypeID">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="AssgnTypeID" DataSourceID="rsTypes" DataTextField="AssgnTypeName"
                                    DataValueField="AssgnTypeID" SelectedValue='<%# Bind("AssgnTypeID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Report Lang.">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="LanguageID" DataSourceID="rsLang" DataTextField="LanguageName"
                                    DataValueField="LanguageID" SelectedValue='<%# Bind("LanguageID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Assgn. Status" SortExpression="AssgnStatus">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="AssgnStatus" DataSourceID="rsStatuses" DataTextField="AssgnStatus"
                                    DataValueField="AssgnStatus" SelectedValue='<%# Bind("AssgnStatus") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<b>Project Ref No.</b>">
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="ProjectRefNo" Text='<%# Bind("ProjectRefNo") %>'></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ID="reqProjectRefNo" ControlToValidate="ProjectRefNo"
                                    Text="*"></asp:RequiredFieldValidator>--%>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="ProjectRefNo" Text='<%# Bind("ProjectRefNo") %>'></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ID="reqProjectRefNo" ControlToValidate="ProjectRefNo"
                                    Text="*"></asp:RequiredFieldValidator>--%>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Comments") %>' TextMode="MultiLine"
                                    Rows="2" Columns="50"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Comments") %>' TextMode="MultiLine"
                                    Rows="2" Columns="50"></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Partner Name" SortExpression="PartnerName">
                            <EditItemTemplate>
                                <asp:TextBox ID="PartnerName" runat="server" Text='<%# Bind("PartnerName") %>' Width="300"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="PartnerName" runat="server" Text='<%# Bind("PartnerName") %>' Width="300"></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="PartnerName" runat="server" Text='<%# Bind("PartnerName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Billing Info" SortExpression="BillingInfo">
                            <EditItemTemplate>
                                <asp:TextBox ID="BillingInfo" runat="server" Text='<%# Bind("BillingInfo") %>' TextMode="MultiLine"
                                    Rows="2" Columns="50"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="BillingInfo" runat="server" Text='<%# Bind("BillingInfo") %>' TextMode="MultiLine"
                                    Rows="2" Columns="50"></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="BillingInfo" runat="server" Text='<%# Bind("BillingInfo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Admin Email Addr." SortExpression="AdminEmailAddress">
                            <EditItemTemplate>
                                <asp:TextBox ID="AdminEmailAddress" runat="server" Text='<%# Bind("AdminEmailAddress") %>'
                                    Width="300"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="AdminEmailAddress" runat="server" Text='<%# Bind("AdminEmailAddress") %>'
                                    Width="300"></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AdminEmailAddress" runat="server" Text='<%# Bind("AdminEmailAddress") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:Button runat="server" ID="btnUpdate" Text="Update" CommandName="Update" OnClientClick="return form_validate();" />
                                &nbsp; &nbsp; &nbsp;
                                <asp:Button runat="server" ID="btnDelete" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this Assignment?');" />
                                &nbsp; &nbsp; &nbsp;
                                <asp:Button runat="server" ID="btnNew" Text="Add Candidate" OnClientClick='<%# "return can_new(" & Eval("AssgnID") & ")" %>' />
                                <div class="error">
                                    Fields in bold are required.</div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:Button runat="server" ID="btnUpdate" Text="Insert" CommandName="Insert" OnClientClick="return form_validate();" />
                                <div class="error">
                                    Fields in bold are required.</div>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Basecamp">
                            <EditItemTemplate>
                                <asp:HyperLink runat="server" ID="hlBasecamp" Text="Basecamp Data" NavigateUrl='<%# "Basecamp.aspx?AssgnID=" & Eval("AssgnID") %>'
                                    Target="basecamp"></asp:HyperLink>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <EditItemTemplate>
                                <asp:HyperLink runat="server" Target="basecamp" ID="hlLoadCandidates" Text="Import Candidates" NavigateUrl='<%# "Candidates_Import.aspx?AssgnID=" & Eval("AssgnID") %>'></asp:HyperLink>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <EditItemTemplate>
                                <asp:HyperLink runat="server" Target="basecamp" ID="hlEmailRpt" Text="Email Reports" NavigateUrl='<%# "CEOx1day.aspx?AssgnID=" & Eval("AssgnID") %>' Visible="false"></asp:HyperLink>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle CssClass="headrow" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Panel runat="server" ID="pCandidates">
        <div class="Heading1">
            Manage Candidates for THIS Assignment
            <asp:Button runat="server" ID="btnReload" Text="Refresh List" />
        </div>
        <div class="note" style="width: 600px;">
            <ol>
                <li style="padding-bottom: 10px;"><b>To send email instructions: </b>Please place a
                    checkmark in the red box, and use the calendar icon (below) to select the completion
                    date, then click the SEND button. To confirm it was sent hit the “refresh button”
                    and the date should appear below.</li>
                <li style="padding-bottom: 10px;"><b>To select finalist report (LFP): To be used with
                    Odgers LeaderFit Potential or Benchmark Report for candidate debriefs. (Additional
                    $150): </b>Please place a checkmark in the green box, and use the calendar icon
                    (below) to select the completion date, then click the SEND button. To confirm it
                    was sent hit the “refresh button” and the date should appear below.</li>
            </ol>
        </div>
        <br />
        <asp:SqlDataSource runat="server" ID="rsCandidates" ConnectionString="<%$ ConnectionStrings:cMain %>"
            SelectCommand="SELECT [AssgnID], [CandidateID], [CandidateName], FirstName, LastName, [IsFinal], EmailAddress, [EmailDate], LanguageID, [HoganUserName], HoganUserPassword, AssgnTypeID, AssgnTypeName, [Comments], [ReportList] FROM [qryAssgnCandidates] WHERE ([AssgnID] = @AssgnID) ORDER BY [CandidateName]">
            <SelectParameters>
                <asp:ControlParameter ControlID="tabList" Name="AssgnID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="tabCandidates" runat="server" AutoGenerateColumns="False" DataKeyNames="AssgnID,CandidateID"
            DataSourceID="rsCandidates" CellPadding="4" HeaderStyle-CssClass="headrow" EmptyDataText="No candidates have been selected."
            AlternatingRowStyle-CssClass="altrow" ShowFooter="True" FooterStyle-CssClass="footrow">
            <Columns>
                <asp:BoundField DataField="CandidateID" HeaderText="CandidateID" ReadOnly="True"
                    SortExpression="CandidateID" Visible="False" />
                <asp:TemplateField HeaderText="Name" SortExpression="CandidateName">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" ID="CandidateName" Text='<%# Eval("CandidateName") %>'
                            NavigateUrl='<%# "Candidates.aspx?CandidateID=" & Eval("CandidateID") %>' Target="new"></asp:HyperLink><br />
                        <asp:Label runat="server" ID="EmailAddress" CssClass="small" Text='<%# Eval("EmailAddress") %>'></asp:Label>
                        <asp:Label runat="server" ID="HoganUserName" Visible="True" Text='<%# Eval("HoganUserName") %>'></asp:Label>/<asp:Label
                            runat="server" ID="HoganUserPassword" Visible="True" Text='<%# Eval("HoganUserPassword") %>'></asp:Label>
                        <asp:Label runat="server" ID="FirstName" Visible="False" Text='<%# Eval("FirstName") %>'></asp:Label>
                        <asp:Label runat="server" ID="LastName" Visible="False" Text='<%# Eval("LastName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="AssgnTypeID" Text='<%# Eval("AssgnTypeID") %>' Visible="False"></asp:Label>
                        <asp:Label runat="server" ID="AssgnTypeName" Text='<%# Eval("AssgnTypeName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="small" />
                    <HeaderTemplate>
                        Hogan Codes Type <font color="red">*</font>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="EmailDate">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="SendEmail" BorderStyle="Solid" BorderColor="Red" /><br />
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmailDate", "{0:dd-MMM-yy}") %>'
                            CssClass="small"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <small>due date</small><br />
                        <BDP:BDPLite ID="DueDate" runat="server" TextBoxStyle-Width="80" ToolTip="Due Date">
                        </BDP:BDPLite>
                        <BDP:DateRequiredValidator ID="valDueDate" runat="server" Text="*" ControlToValidate="DueDate"
                            ValidationGroup="Email"></BDP:DateRequiredValidator>
                        <asp:Button runat="server" ID="btnSend" Text="SEND" CommandName="Email" ValidationGroup="Email" />
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <FooterStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        Send Email?<br />
                        <span class="small">date email sent</span>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="LanguageID" HeaderText="Email Invite Lang.">
                    <ItemTemplate>
                        <asp:DropDownList ID="LanguageID" runat="server" Enabled="False" DataSourceID="rsLang"
                            DataTextField="LanguageName" DataValueField="LanguageID" SelectedValue='<%# Eval("LanguageID") %>'>
                        </asp:DropDownList>
                    </ItemTemplate>
                    <HeaderStyle CssClass="small" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Finalist Selection" SortExpression="Comments">
                    <ItemTemplate>
                        <span class="small">
                            <%--Generate Leadership Forecast Potential Report:--%>
                            Request Finalist LFP Report:
                            <asp:CheckBox runat="server" ID="IsFinal" BorderStyle="Solid" BorderColor="Green"
                                Checked='<%# Eval("IsFinal") %>' /></span>
                        <br />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Button runat="server" ID="btnUpdate" Text="Update" CommandName="UpdateC" />
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <%--            <asp:BoundField DataField="HoganCodes" HeaderText="Hogan Codes" ReadOnly="True" SortExpression="HoganCodes" />
                --%>
                <asp:BoundField DataField="ReportList" HeaderText="Reports List" ReadOnly="True"
                    SortExpression="ReportList" />
                <asp:TemplateField HeaderText="Delete?" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:CheckBox runat="Server" ID="DoDelete"></asp:CheckBox>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Button runat="server" ID="bnDelete" Text="Delete" CommandName="DeleteC" OnClientClick="return confirm('Are you sure you want to delete the checked Candidates from THIS Assignment?');" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="footrow" />
            <HeaderStyle CssClass="headrow" />
            <AlternatingRowStyle CssClass="altrow" />
        </asp:GridView>
        <span class="small"><font color="red"><b>*</b>In cases where the Hogan Codes Type is
            red, Hogan codes don't match Assignment Type. Please email sonya@performanceprograms.com
            for assistance.</font></span>
    </asp:Panel>
    <br />
    <br />
    <asp:Panel runat="server" ID="pQuickadd">
        <div class="Heading1">
            <br />
            Quick-add Candidates (Search by Email Address)</div>
        Email Address:
        <asp:TextBox runat="server" ID="EmailAddress" Width="300"></asp:TextBox>
        <asp:Button runat="server" ID="btnSearch" Text="Search" /><br />
        <br />
        <asp:SqlDataSource runat="server" ID="rsSearch" ConnectionString="<%$ ConnectionStrings:cMain %>"
            SelectCommand="SELECT [FirstName], [LastName], [CandidateID], [EmailAddress] FROM [Candidates] WHERE (CHARINDEX(@EmailAddress, EmailAddress) > 0) and (((SELECT AssgnID FROM AssgnCandidates WHERE CandidateID = Candidates.CandidateID AND AssgnID = @AssgnID) IS NULL)) ORDER BY [LastName], [FirstName]">
            <SelectParameters>
                <asp:ControlParameter ControlID="EmailAddress" Name="EmailAddress" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="tabList" Name="AssgnID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="tabSearch" runat="server" AutoGenerateColumns="False" DataKeyNames="CandidateID"
            DataSourceID="rsSearch" CellPadding="4" CellSpacing="0" HeaderStyle-CssClass="headrow"
            EmptyDataText="No matches found.">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button runat="server" ID="btnAdd" Text="Select" CommandName="Select" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:BoundField DataField="CandidateID" Visible="False" HeaderText="CandidateID"
                    InsertVisible="False" ReadOnly="True" SortExpression="CandidateID" />
                <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
    <div runat="server" id="divalert" enableviewstate="false">
    </div>
    <script type="text/javascript" language="javascript">
        var w1;
        function can_new(which) {
            //alert(which);
            w1 = window.open("Candidates.aspx?CandidateID=0&AssgnID=" + which, "new");
            return (false);
        }

        var reporttype_prev = new Number(0);


        function reporttype_alert() {
            var msg = new String('');
            var confirm_show = new Number(0);

            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_AssgnTypeID');
            if (e1.options[e1.selectedIndex].text == 'Potential') {
                msg = 'This is $500 (HPI). \n\n Generates 1 Basis report.';
            }

            if (e1.options[e1.selectedIndex].text == 'Benchmark') {
                msg = 'This is $1300 and uses all 3 instruments (HPI, HDS and MVPI). \n\n Generates 1 Basis Report.';
            }

            if (e1.options[e1.selectedIndex].text == 'Executive') {
                msg = 'This is $5500 with a search/$7500 standalone (HPI, HDS, MVPI and HBRI). \n\n Generates 5 Reports: Potential, Challenge, Values, Coaching and Business Reasoning Inventory. \n\n Please confirm that this is the assessment you wish to select.';
                confirm_show = 1;
            }

            if (e1.options[e1.selectedIndex].text == 'Leadership Forecast Report') {
                msg = 'Please do not select this option without first speaking with Kristen or Eric. \n\n Internal cost: $150. \n\n Generates 1 Potential Report.';
            }

            if (e1.options[e1.selectedIndex].text == 'Leadership Forecast Series') {
                msg = 'Please do not select this option without first speaking with Kristen or Eric. \n\n Internal cost: $400. \n\n Generates 4 Reports: Potential, Challenge, Values, Coaching.';
            }

            if (confirm_show == 1) {
                if (!confirm(msg)) e1.selectedIndex = reporttype_prev;
            } else {
                if (msg != '') alert(msg);
            }

            return (true);

            /*msg='You are requesting an Executive assessment set which is the full blown, $5,500 or $7,500 version.\n\nThe individual will receive 4 Hogan instruments (HPI, HDS, MVPI and HBRI). \n\nPlease confirm that this is the assessment you wish to select.';
            alert(e1.options[e1.selectedIndex].text);
            if ((e1.options[e1.selectedIndex].text=='LF Potential') || (e1.options[e1.selectedIndex].text=='Executive')) {
            return(confirm(msg));
            }*/
        }


        function reporttype_remember() {
            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_AssgnTypeID');
            reporttype_prev = e1.selectedIndex;
            //alert(reporttype_prev);
        }



        function echeck(str) {
            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)
            //            if (str.indexOf(at) == -1) {
            //                alert("Invalid E-mail -- no @ symbol")
            //                return false
            //            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
                alert("Invalid location of @ symbol")
                return false
            }

            //alert(str.indexOf(dot));
            //alert(lstr);
            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) + 1 == lstr) {
                alert("Invalid location of dot")
                return false
            }

            if (str.indexOf(at, (lat + 1)) != -1) {
                alert("Invalid E-mail ID4")
                return false
            }

            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
                alert("Invalid E-mail ID5")
                return false
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
                alert("Invalid E-mail ID6")
                return false
            }

            if (str.indexOf(" ") != -1) {
                alert("Invalid E-mail ID7")
                return false
            }

            return true
        }

        function form_validate() {
            var e1;

            //Client Name, Assignment Desc and Project RefNo
            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_ClientName');
            //alert(e1.value);
            if (e1.value == '') {
                alert('Please enter Client Name.');
                e1.focus();
                return (false);
            }


            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_AssgnDesc');
            //alert(e1.value);
            if (e1.value == '') {
                alert('Please enter Assignment Title.');
                e1.focus();
                return (false);
            }

            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_ProjectRefNo');
            //alert(e1.value);
            if (e1.value == '') {
                alert('Please enter Project Ref. No.');
                e1.focus();
                return (false);
            }


            //alert about reporttype='LF Potential'
            if (reporttype_alert() == false) return (false);


            //validate email address
            e1 = document.getElementById('ctl00_ContentPlaceHolder1_tabDetail_AdminEmailAddress');
            //alert(e1.value);
            if ((e1.value == null) || (e1.value == "")) {
                alert("Please enter Admin Email Address");
                e1.focus();
                return false
            }

            //array of semi-colon separated emails
            var s1 = new String(e1.value);
            var emails = s1.split(";");
            for (var i1 = 0; i1 < emails.length; i1++) {
                s1 = emails[i1];
                s1 = s1.replace(' ', '');
                if (echeck(s1) == false) {
                    e1.focus();
                    return false;
                }
            }
            return (true);

        }

        function filter(ltr1) {
            var e1;
            e1 = document.forms[0].ctl00_ContentPlaceHolder1_StartsWith;
            e1.value = ltr1;
            document.forms[0].submit();
        }
    </script>
</asp:Content>
