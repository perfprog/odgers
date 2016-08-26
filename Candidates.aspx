<%@ Page Language="VB" Trace="true" Debug="false" MasterPageFile="~/admin.master"
    AutoEventWireup="false" CodeFile="Candidates.aspx.vb" Inherits="Candidates" Title="Candidates"
    StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Heading1">
        Manage Candidates</div>
    <br />
    <asp:SqlDataSource ID="rsLang" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [LanguageName] FROM [Languages] ORDER BY [LanguageID]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="rsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [AssgnTypeID], AssgnTypeName FROM [AssgnTypes] ORDER BY [AssgnTypeID]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="rsCandidate" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        DeleteCommand="DELETE FROM [Candidates] WHERE [CandidateID] = @CandidateID" InsertCommand="INSERT INTO [Candidates] ([FirstName], [LastName], [EmailAddress], Gender, [Address1], [Address2], [City], [Province], [PostalCode], [Phone_Home], [Phone_Cell], Phone_Work, [Comments], [LanguageID]) VALUES (@FirstName, @LastName, @EmailAddress, @Gender, @Address1, @Address2, @City, @Province, @PostalCode, @Phone_Home, @Phone_Cell, @Phone_Work, @Comments, @LanguageID); SELECT @NewID = @@Identity"
        SelectCommand="SELECT [CandidateID], [FirstName], [LastName], [EmailAddress], gender, [Address1], [Address2], [City], [Province], [PostalCode], [Phone_Home], [Phone_Cell], Phone_Work, [Comments], [HoganUserName], [HoganUserPassword], AssgnTypeID, AssgnTypeName, [LanguageID], [LF1], [LF2], [LF3], [LF4], [LF5] FROM [qryCandidates] WHERE ([CandidateID] = @CandidateID)"
        UpdateCommand="UPDATE [Candidates] SET [FirstName] = @FirstName, [LastName] = @LastName, [EmailAddress] = @EmailAddress, Gender=@Gender, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [Province] = @Province, [PostalCode] = @PostalCode, [Phone_Home] = @Phone_Home, [Phone_Cell] = @Phone_Cell, Phone_Work=@Phone_Work, [Comments] = @Comments, [LanguageID] = @LanguageID WHERE [CandidateID] = @CandidateID">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CandidateID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="Address1" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="Province" Type="String" />
            <asp:Parameter Name="PostalCode" Type="String" />
            <asp:Parameter Name="Phone_Home" Type="String" />
            <asp:Parameter Name="Phone_Cell" Type="String" />
            <asp:Parameter Name="Phone_Work" Type="String" />
            <asp:Parameter Name="Comments" Type="String" />
            <asp:Parameter Name="LanguageID" Type="Int16" />
            <asp:Parameter Name="CandidateID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="Address1" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="Province" Type="String" />
            <asp:Parameter Name="PostalCode" Type="String" />
            <asp:Parameter Name="Phone_Home" Type="String" />
            <asp:Parameter Name="Phone_Cell" Type="String" />
            <asp:Parameter Name="Phone_Work" Type="String" />
            <asp:Parameter Name="Comments" Type="String" />
            <asp:Parameter Name="LanguageID" Type="Byte" />
            <asp:Parameter Direction="Output" Name="NewID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="frmCandidate" runat="server" AutoGenerateRows="False" DataKeyNames="CandidateID"
        DataSourceID="rsCandidate" DefaultMode="Edit" CellPadding="4">
        <Fields>
            <asp:BoundField DataField="CandidateID" HeaderText="Candidate ID" InsertVisible="False"
                ReadOnly="True" SortExpression="CandidateID" />
            <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                <EditItemTemplate>
                    <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <b>First Name</b>
                    <asp:RequiredFieldValidator runat="server" ID="reqFirstName" Text="*" ControlToValidate="FirstName"></asp:RequiredFieldValidator>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                <EditItemTemplate>
                    <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <b>Last Name</b>
                    <asp:RequiredFieldValidator runat="server" ID="reqLastName" Text="*" ControlToValidate="LastName"></asp:RequiredFieldValidator>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email Address" SortExpression="EmailAddress">
                <EditItemTemplate>
                    <asp:TextBox ID="EmailAddress" runat="server" Text='<%# Bind("EmailAddress") %>'
                        Width="300"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ID="regEmailAddress" Text="Invalid Email Address"
                        ControlToValidate="EmailAddress" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*"></asp:RegularExpressionValidator><br />
                    <span class="small">separate multiple email addresses using ";"</span>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="EmailAddress" runat="server" Text='<%# Bind("EmailAddress") %>'
                        Width="300"></asp:TextBox>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <b>Email Address</b>
                    <asp:RequiredFieldValidator runat="server" ID="reqEmailAddress" Text="*" ControlToValidate="EmailAddress"></asp:RequiredFieldValidator>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                <EditItemTemplate>
                    <asp:DropDownList runat="server" ID="Gender" SelectedValue='<%# Bind("Gender") %>'>
                        <asp:ListItem value="" text="-- Choose --"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList runat="server" ID="Gender" SelectedValue='<%# Bind("Gender") %>'>
                        <asp:ListItem value="" Text="-- Choose --"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    </asp:DropDownList>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <b>Gender</b>
                    <asp:RequiredFieldValidator runat="server" ID="reqGender" Text="*" ControlToValidate="Gender"></asp:RequiredFieldValidator>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Address1" HeaderText="Address1" SortExpression="Address1">
                <ControlStyle Width="300px" />
            </asp:BoundField>
            <asp:BoundField DataField="Address2" HeaderText="Address2" SortExpression="Address2">
                <ControlStyle Width="300px" />
            </asp:BoundField>
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City">
                <ControlStyle Width="300px" />
            </asp:BoundField>
            <asp:BoundField DataField="Province" HeaderText="Province" SortExpression="Province" />
            <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" SortExpression="PostalCode" />
            <asp:BoundField DataField="Phone_Home" HeaderText="Home Phone" SortExpression="Phone_Home"
                ControlStyle-Width="300" />
            <asp:BoundField DataField="Phone_Cell" HeaderText="Cell Phone" SortExpression="Phone_Cell"
                ControlStyle-Width="300" />
            <asp:BoundField DataField="Phone_Work" HeaderText="Work Phone" SortExpression="Phone_Work"
                ControlStyle-Width="300" />
            <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Comments") %>' TextMode="MultiLine"
                        Rows="4" Columns="50"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Comments") %>' TextMode="MultiLine"
                        Rows="4" Columns="50"></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Hogan Codes" SortExpression="HoganUserName">
                <EditItemTemplate>
                    <asp:Label ID="HoganUserName" runat="server" Text='<%# Eval("HoganUserName") %>'
                        Visible="False"></asp:Label>
                    <asp:Label ID="HoganCodes" runat="server" Text='<%# Eval("HoganUserName") & " / " & Eval("HoganUserPassword") %>'></asp:Label>
                    <span class="small">(<asp:Label runat="server" ID="AssgnTypeName" Text='<%# Eval("AssgnTypeName") %>'></asp:Label>)</span>
                    <div runat="server" id="divHogan">
                        <asp:DropDownList runat="server" ID="ddAssgnTypeID" DataSourceID="rsTypes" DataTextField="AssgnTypeName"
                            DataValueField="AssgnTypeID" SelectedValue='<%# Eval("AssgnTypeID") %>' AppendDataBoundItems=true>
                       <asp:ListItem Text="" Value=" -- select --"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button runat="server" ID="btnHogan" Text="Assign Hogan Codes" CommandName="Hogan" />
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField SortExpression="LanguageID">
                <EditItemTemplate>
                    <asp:DropDownList ID="LanguageID" runat="server" DataSourceID="rsLang" DataTextField="LanguageName"
                        DataValueField="LanguageID" SelectedValue='<%# Bind("LanguageID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="LanguageID" runat="server" DataSourceID="rsLang" DataTextField="LanguageName"
                        DataValueField="LanguageID" SelectedValue='<%# Bind("LanguageID") %>'>
                    </asp:DropDownList>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <span class="small">Lang. for Odgers Custom Reports</span>
                </HeaderTemplate>
            </asp:TemplateField>
            <%-- <asp:TemplateField SortExpression="LanguageID_Rpt">
                <EditItemTemplate>
                    <asp:DropDownList ID="LanguageID_Rpt" runat="server" DataSourceID="rsLang" DataTextField="LanguageName"
                        DataValueField="LanguageID" SelectedValue='<%# Bind("LanguageID_Rpt") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="LanguageID_Rpt" runat="server" DataSourceID="rsLang" DataTextField="LanguageName"
                        DataValueField="LanguageID" SelectedValue='<%# Bind("LanguageID_Rpt") %>'>
                    </asp:DropDownList>
                </InsertItemTemplate>
                <HeaderTemplate>
                    <span class="small">Report Lang.</span>
                </HeaderTemplate>
            </asp:TemplateField>--%>
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:Button runat="server" ID="btnUpdate" Text="Update" CommandName="Update" />
                    &nbsp; &nbsp; &nbsp;
                    <%--<asp:Button runat=server ID=btnNew Text="Add Candidate" CommandName="New" />
                    --%>
                    <div class="error">
                        Fields in bold are required.</div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:Button runat="server" ID="btnUpdate" Text="Insert" CommandName="Insert" />
                    <div class="error">
                        Fields in bold are required.</div>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:TextBox ID="LF1" runat="server" Text='<%# Bind("LF1") %>' style="display:none;"></asp:TextBox>
                    <asp:TextBox ID="LF2" runat="server" Text='<%# Bind("LF2")%>' style="display:none;"></asp:TextBox>
                    <asp:TextBox ID="LF3" runat="server" Text='<%# Bind("LF3")%>' style="display:none;"></asp:TextBox>
                    <asp:TextBox ID="LF4" runat="server" Text='<%# Bind("LF4")%>' style="display:none;"></asp:TextBox>
                    <asp:TextBox ID="LF5" runat="server" Text='<%# Bind("LF5")%>' style="display:none;"></asp:TextBox>

                    <asp:Button runat="server" ID="btnReport" Text="Generate Odgers Reports" CommandName="Reports" />
                    <a href="javascript:location.reload(true)">Refresh</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <asp:Hyperlink runat=server ID=hlScores Text="View/Edit Hogan Scores" NavigateUrl='<%# "CandidateScores.aspx?CandidateID=" & Eval("CandidateID") %>' Target="w2"></asp:Hyperlink>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
                    
                </InsertItemTemplate>
            </asp:TemplateField>


        </Fields>
    </asp:DetailsView>
    <asp:Label runat="server" ID="Message" EnableViewState="False" CssClass="error"></asp:Label>
    <br />
    <br />
    <script type="text/javascript" language="javascript">
        function parent_reload() {
            alert('reloading opener');
            window.opener.location.href = window.opener.location.href;
        }

        // **** The following disables the generate report button if any of the Leader Fit scores are null **** //
        // Prevents billing event if no data for the report.

        var lf1 = document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_LF1").value;
        var lf2 = document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_LF2").value;
        var lf3 = document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_LF3").value;
        var lf4 = document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_LF4").value;
        var lf5 = document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_LF5").value;

        //alert('LF1: ' + lf1 + '\n\rLF2: ' + lf2 + '\n\rLF3: ' + lf3 + '\n\rLF4: ' + lf4 + '\n\rLF5: ' + lf5);

        if (lf1 == "" || lf2 == "" || lf3 == "" || lf4 == "" || lf5 == "") {
            document.getElementById("ctl00_ContentPlaceHolder1_frmCandidate_btnReport").disabled = true; 
        }

    </script>
</asp:Content>
