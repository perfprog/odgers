<%@ Page Title="Candidate Scores" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="CandidateScores.aspx.vb"
    Inherits="CandidateScores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsC" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT * FROM [Candidates] WHERE ([CandidateID] = @CandidateID)"        
        UpdateCommand="UPDATE [Candidates] SET [FirstName] = @FirstName, [LastName] = @LastName, Valid=@Valid, [HPI1] = @HPI1, [HPI2] = @HPI2, [HPI3] = @HPI3, [HPI4] = @HPI4, [HPI5] = @HPI5, [HPI6] = @HPI6, [HPI7] = @HPI7, [HDS1] = @HDS1, [HDS2] = @HDS2, [HDS3] = @HDS3, [HDS4] = @HDS4, [HDS5] = @HDS5, [HDS6] = @HDS6, [HDS7] = @HDS7, [HDS8] = @HDS8, [HDS9] = @HDS9, [HDS10] = @HDS10, [HDS11] = @HDS11, [MVPI1] = @MVPI1, [MVPI2] = @MVPI2, [MVPI3] = @MVPI3, [MVPI4] = @MVPI4, [MVPI5] = @MVPI5, [MVPI6] = @MVPI6, [MVPI7] = @MVPI7, [MVPI8] = @MVPI8, [MVPI9] = @MVPI9, [MVPI10] = @MVPI10, [LF1] = @LF1, [LF2] = @LF2, [LF3] = @LF3, [LF4] = @LF4, [LF5] = @LF5, [HPIs2] = @HPIs2, [HPIs3] = @HPIs3, [HPIs4] = @HPIs4, [HPIs5] = @HPIs5, [HPIs6] = @HPIs6, [HPIs7] = @HPIs7, HPIs8=@HPIs8, HPIs9=@HPIs9, HPIs10=@HPIs10, HPIs11=@HPIs11, [HPIs12] = @HPIs12, [HPIs13] = @HPIs13, [HPIs14] = @HPIs14, [HPIs15] = @HPIs15, [HPIs16] = @HPIs16, [HPIs17] = @HPIs17, HPIs18=@HPIs18, HPIs19=@HPIs19, HPIs20=@HPIs20, HPIs21=@HPIs21, [HPIs22] = @HPIs22, [HPIs23] = @HPIs23, [HPIs24] = @HPIs24, [HPIs25] = @HPIs25, [HPIs26] = @HPIs26, [HPIs27] = @HPIs27, HPIs28=@HPIs28, HPIs29=@HPIs29, HPIs30=@HPIs30, HPIs31=@HPIs31, [HPIs32] = @HPIs32, [HPIs33] = @HPIs33, [HPIs34] = @HPIs34, [HPIs35] = @HPIs35, [HPIs36] = @HPIs36, [HPIs37] = @HPIs37, HPIs38=@HPIs38, HPIs39=@HPIs39, HPIs40=@HPIs40, HPIs41=@HPIs41, HPIs42=@HPIs42,HDSs1=@HDSs1,HDSs2=@HDSs2,HDSs3=@HDSs3,HDSs4=@HDSs4,HDSs5=@HDSs5,HDSs6=@HDSs6,HDSs7=@HDSs7,HDSs8=@HDSs8,HDSs9=@HDSs9,HDSs10=@HDSs10,HDSs11=@HDSs11,HDSs12=@HDSs12,HDSs13=@HDSs13,HDSs14=@HDSs14,HDSs15=@HDSs15,HDSs16=@HDSs16,HDSs17=@HDSs17,HDSs18=@HDSs18,HDSs19=@HDSs19,HDSs20=@HDSs20,HDSs21=@HDSs21,HDSs22=@HDSs22,HDSs23=@HDSs23,HDSs24=@HDSs24,HDSs25=@HDSs25,HDSs26=@HDSs26,HDSs27=@HDSs27,HDSs28=@HDSs28,HDSs29=@HDSs29,HDSs30=@HDSs30,HDSs31=@HDSs31,HDSs32=@HDSs32,HDSs33=@HDSs33,MVPIs1=@MVPIs1,MVPIs2=@MVPIs2,MVPIs3=@MVPIs3,MVPIs4=@MVPIs4,MVPIs5=@MVPIs5,MVPIs6=@MVPIs6,MVPIs7=@MVPIs7,MVPIs8=@MVPIs8,MVPIs9=@MVPIs9,MVPIs10=@MVPIs10,MVPIs11=@MVPIs11,MVPIs12=@MVPIs12,MVPIs13=@MVPIs13,MVPIs14=@MVPIs14,MVPIs15=@MVPIs15,MVPIs16=@MVPIs16,MVPIs17=@MVPIs17,MVPIs18=@MVPIs18,MVPIs19=@MVPIs19,MVPIs20=@MVPIs20,MVPIs21=@MVPIs21,MVPIs22=@MVPIs22,MVPIs23=@MVPIs23,MVPIs24=@MVPIs24,MVPIs25=@MVPIs25,MVPIs26=@MVPIs26,MVPIs27=@MVPIs27,MVPIs28=@MVPIs28,MVPIs29=@MVPIs29,MVPIs30=@MVPIs30,MVPIs31=@MVPIs31,MVPIs32=@MVPIs32,MVPIs33=@MVPIs33,MVPIs34=@MVPIs34,MVPIs35=@MVPIs35,MVPIs36=@MVPIs36,MVPIs37=@MVPIs37,MVPIs38=@MVPIs38,MVPIs39=@MVPIs39,MVPIs40=@MVPIs40,MVPIs41=@MVPIs41,MVPIs42=@MVPIs42,MVPIs43=@MVPIs43,MVPIs44=@MVPIs44,MVPIs45=@MVPIs45,MVPIs46=@MVPIs46,MVPIs47=@MVPIs47,MVPIs48=@MVPIs48,MVPIs49=@MVPIs49,MVPIs50=@MVPIs50 WHERE [CandidateID] = @CandidateID">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Valid" Type="Byte" />
            <asp:Parameter Name="HPI1" Type="Byte" />
            <asp:Parameter Name="HPI2" Type="Byte" />
            <asp:Parameter Name="HPI3" Type="Byte" />
            <asp:Parameter Name="HPI4" Type="Byte" />
            <asp:Parameter Name="HPI5" Type="Byte" />
            <asp:Parameter Name="HPI6" Type="Byte" />
            <asp:Parameter Name="HPI7" Type="Byte" />
            <asp:Parameter Name="HDS1" Type="Byte" />
            <asp:Parameter Name="HDS2" Type="Byte" />
            <asp:Parameter Name="HDS3" Type="Byte" />
            <asp:Parameter Name="HDS4" Type="Byte" />
            <asp:Parameter Name="HDS5" Type="Byte" />
            <asp:Parameter Name="HDS6" Type="Byte" />
            <asp:Parameter Name="HDS7" Type="Byte" />
            <asp:Parameter Name="HDS8" Type="Byte" />
            <asp:Parameter Name="HDS9" Type="Byte" />
            <asp:Parameter Name="HDS10" Type="Byte" />
            <asp:Parameter Name="HDS11" Type="Byte" />
            <asp:Parameter Name="MVPI1" Type="Byte" />
            <asp:Parameter Name="MVPI2" Type="Byte" />
            <asp:Parameter Name="MVPI3" Type="Byte" />
            <asp:Parameter Name="MVPI4" Type="Byte" />
            <asp:Parameter Name="MVPI5" Type="Byte" />
            <asp:Parameter Name="MVPI6" Type="Byte" />
            <asp:Parameter Name="MVPI7" Type="Byte" />
            <asp:Parameter Name="MVPI8" Type="Byte" />
            <asp:Parameter Name="MVPI9" Type="Byte" />
            <asp:Parameter Name="MVPI10" Type="Byte" />
            <asp:Parameter Name="LF1" Type="Int32" />
            <asp:Parameter Name="LF2" Type="Int32" />
            <asp:Parameter Name="LF3" Type="Int32" />
            <asp:Parameter Name="LF4" Type="Int32" />
            <asp:Parameter Name="LF5" Type="Int32" />
            <asp:Parameter Name="HPIs2" Type="Byte" />
            <asp:Parameter Name="HPIs3" Type="Byte" />
            <asp:Parameter Name="HPIs4" Type="Byte" />
            <asp:Parameter Name="HPIs5" Type="Byte" />
            <asp:Parameter Name="HPIs6" Type="Byte" />
            <asp:Parameter Name="HPIs7" Type="Byte" />
            <asp:Parameter Name="HPIs8" Type="Byte" />
            <asp:Parameter Name="HPIs9" Type="Byte" />
            <asp:Parameter Name="HPIs10" Type="Byte" />
            <asp:Parameter Name="HPIs11" Type="Byte" />
            <asp:Parameter Name="HPIs12" Type="Byte" />
            <asp:Parameter Name="HPIs13" Type="Byte" />
            <asp:Parameter Name="HPIs14" Type="Byte" />
            <asp:Parameter Name="HPIs15" Type="Byte" />
            <asp:Parameter Name="HPIs16" Type="Byte" />
            <asp:Parameter Name="HPIs17" Type="Byte" />
            <asp:Parameter Name="HPIs18" Type="Byte" />
            <asp:Parameter Name="HPIs19" Type="Byte" />
            <asp:Parameter Name="HPIs20" Type="Byte" />
            <asp:Parameter Name="HPIs21" Type="Byte" />
            <asp:Parameter Name="HPIs22" Type="Byte" />
            <asp:Parameter Name="HPIs23" Type="Byte" />
            <asp:Parameter Name="HPIs24" Type="Byte" />
            <asp:Parameter Name="HPIs25" Type="Byte" />
            <asp:Parameter Name="HPIs26" Type="Byte" />
            <asp:Parameter Name="HPIs27" Type="Byte" />
            <asp:Parameter Name="HPIs28" Type="Byte" />
            <asp:Parameter Name="HPIs29" Type="Byte" />
            <asp:Parameter Name="HPIs30" Type="Byte" />
            <asp:Parameter Name="HPIs31" Type="Byte" />
            <asp:Parameter Name="HPIs32" Type="Byte" />
            <asp:Parameter Name="HPIs33" Type="Byte" />
            <asp:Parameter Name="HPIs34" Type="Byte" />
            <asp:Parameter Name="HPIs35" Type="Byte" />
            <asp:Parameter Name="HPIs36" Type="Byte" />
            <asp:Parameter Name="HPIs37" Type="Byte" />
            <asp:Parameter Name="HPIs38" Type="Byte" />
            <asp:Parameter Name="HPIs39" Type="Byte" />
            <asp:Parameter Name="HPIs40" Type="Byte" />
            <asp:Parameter Name="HPIs41" Type="Byte" />
            <asp:Parameter Name="HPIs42" Type="Byte" />
            
            <asp:Parameter Name="HDSs1" Type="Byte" />
            <asp:Parameter Name="HDSs2" Type="Byte" />
            <asp:Parameter Name="HDSs3" Type="Byte" />
            <asp:Parameter Name="HDSs4" Type="Byte" />
            <asp:Parameter Name="HDSs5" Type="Byte" />
            <asp:Parameter Name="HDSs6" Type="Byte" />
            <asp:Parameter Name="HDSs7" Type="Byte" />
            <asp:Parameter Name="HDSs8" Type="Byte" />
            <asp:Parameter Name="HDSs9" Type="Byte" />
            <asp:Parameter Name="HDSs10" Type="Byte" />
            <asp:Parameter Name="HDSs11" Type="Byte" />
            <asp:Parameter Name="HDSs12" Type="Byte" />
            <asp:Parameter Name="HDSs13" Type="Byte" />
            <asp:Parameter Name="HDSs14" Type="Byte" />
            <asp:Parameter Name="HDSs15" Type="Byte" />
            <asp:Parameter Name="HDSs16" Type="Byte" />
            <asp:Parameter Name="HDSs17" Type="Byte" />
            <asp:Parameter Name="HDSs18" Type="Byte" />
            <asp:Parameter Name="HDSs19" Type="Byte" />
            <asp:Parameter Name="HDSs20" Type="Byte" />
            <asp:Parameter Name="HDSs21" Type="Byte" />
            <asp:Parameter Name="HDSs22" Type="Byte" />
            <asp:Parameter Name="HDSs23" Type="Byte" />
            <asp:Parameter Name="HDSs24" Type="Byte" />
            <asp:Parameter Name="HDSs25" Type="Byte" />
            <asp:Parameter Name="HDSs26" Type="Byte" />
            <asp:Parameter Name="HDSs27" Type="Byte" />
            <asp:Parameter Name="HDSs28" Type="Byte" />
            <asp:Parameter Name="HDSs29" Type="Byte" />
            <asp:Parameter Name="HDSs30" Type="Byte" />
            <asp:Parameter Name="HDSs31" Type="Byte" />
            <asp:Parameter Name="HDSs32" Type="Byte" />
            <asp:Parameter Name="HDSs33" Type="Byte" />
            
            <asp:Parameter Name="MVPIs1" Type="Byte" />
            <asp:Parameter Name="MVPIs2" Type="Byte" />
            <asp:Parameter Name="MVPIs3" Type="Byte" />
            <asp:Parameter Name="MVPIs4" Type="Byte" />
            <asp:Parameter Name="MVPIs5" Type="Byte" />
            <asp:Parameter Name="MVPIs6" Type="Byte" />
            <asp:Parameter Name="MVPIs7" Type="Byte" />
            <asp:Parameter Name="MVPIs8" Type="Byte" />
            <asp:Parameter Name="MVPIs9" Type="Byte" />
            <asp:Parameter Name="MVPIs10" Type="Byte" />
            <asp:Parameter Name="MVPIs11" Type="Byte" />
            <asp:Parameter Name="MVPIs12" Type="Byte" />
            <asp:Parameter Name="MVPIs13" Type="Byte" />
            <asp:Parameter Name="MVPIs14" Type="Byte" />
            <asp:Parameter Name="MVPIs15" Type="Byte" />
            <asp:Parameter Name="MVPIs16" Type="Byte" />
            <asp:Parameter Name="MVPIs17" Type="Byte" />
            <asp:Parameter Name="MVPIs18" Type="Byte" />
            <asp:Parameter Name="MVPIs19" Type="Byte" />
            <asp:Parameter Name="MVPIs20" Type="Byte" />
            <asp:Parameter Name="MVPIs21" Type="Byte" />
            <asp:Parameter Name="MVPIs22" Type="Byte" />
            <asp:Parameter Name="MVPIs23" Type="Byte" />
            <asp:Parameter Name="MVPIs24" Type="Byte" />
            <asp:Parameter Name="MVPIs25" Type="Byte" />
            <asp:Parameter Name="MVPIs26" Type="Byte" />
            <asp:Parameter Name="MVPIs27" Type="Byte" />
            <asp:Parameter Name="MVPIs28" Type="Byte" />
            <asp:Parameter Name="MVPIs29" Type="Byte" />
            <asp:Parameter Name="MVPIs30" Type="Byte" />
            <asp:Parameter Name="MVPIs31" Type="Byte" />
            <asp:Parameter Name="MVPIs32" Type="Byte" />
            <asp:Parameter Name="MVPIs33" Type="Byte" />
            <asp:Parameter Name="MVPIs34" Type="Byte" />
            <asp:Parameter Name="MVPIs35" Type="Byte" />
            <asp:Parameter Name="MVPIs36" Type="Byte" />
            <asp:Parameter Name="MVPIs37" Type="Byte" />
            <asp:Parameter Name="MVPIs38" Type="Byte" />
            <asp:Parameter Name="MVPIs39" Type="Byte" />
            <asp:Parameter Name="MVPIs40" Type="Byte" />
            <asp:Parameter Name="MVPIs41" Type="Byte" />
            <asp:Parameter Name="MVPIs42" Type="Byte" />
            <asp:Parameter Name="MVPIs43" Type="Byte" />
            <asp:Parameter Name="MVPIs44" Type="Byte" />
            <asp:Parameter Name="MVPIs45" Type="Byte" />
            <asp:Parameter Name="MVPIs46" Type="Byte" />
            <asp:Parameter Name="MVPIs47" Type="Byte" />
            <asp:Parameter Name="MVPIs48" Type="Byte" />
            <asp:Parameter Name="MVPIs49" Type="Byte" />
            <asp:Parameter Name="MVPIs50" Type="Byte" />
            

            <asp:Parameter Name="CandidateID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="frmC" runat="server" DataKeyNames="CandidateID" DefaultMode="Edit"
        BorderStyle="Solid" BorderColor="Black" DataSourceID="rsC" EnableModelValidation="True">
        <EditItemTemplate>
            <table cellspacing="0" cellpadding="3" border="1">
                <tr>
                    <td>
                        <b>CandidateID:</b><br />
                        <asp:Label ID="CandidateIDLabel1" runat="server" Text='<%# Eval("CandidateID") %>' />
                    </td>
                    <td>
                        <b>FirstName:</b><br />
                        <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>' />
                    </td>
                    <td>
                        <b>LastName:</b><br />
                        <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>' />
                    </td>
                    <td>
                        <b>Valid:</b><br />
                        <asp:TextBox ID="Valid" Width="30" runat="server" Text='<%# Bind("Valid") %>' />
                    </td>
                    <td>
                    </td>
                     <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>HPI</b>
                    </td>
                    <td>
                        <b>HDS</b>
                    </td>
                    <td>
                        <b>MVPI</b>
                    </td>
                    <td>
                        <b>LeaderFit</b>
                    </td>
                    <td align="center">
                        <b>HPIs</b>
                    </td>
                    <td align="center">
                        <b>HDSs</b>
                    </td>
                    <td align="center">
                        <b>MVPIs</b>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        ADJU:
                        <asp:TextBox ID="HPI1" Width="30" runat="server" ToolTip="Adjustment" Text='<%# Bind("HPI1") %>' />
                        <br />
                        AMBI:
                        <asp:TextBox ID="HPI2" Width="30" runat="server" ToolTip="Ambition" Text='<%# Bind("HPI2") %>' />
                        <br />
                        SOCI:
                        <asp:TextBox ID="HPI3" Width="30" runat="server" ToolTip="Sociability" Text='<%# Bind("HPI3") %>' />
                        <br />
                        INTS:
                        <asp:TextBox ID="HPI4" Width="30" runat="server" ToolTip="Interpersonal Sensitivity" Text='<%# Bind("HPI4") %>' />
                        <br />
                        PRUD:
                        <asp:TextBox ID="HPI5" Width="30" runat="server" ToolTip="Prudence" Text='<%# Bind("HPI5") %>' />
                        <br />
                        INQU:
                        <asp:TextBox ID="HPI6" Width="30" runat="server" ToolTip="Inquisitive" Text='<%# Bind("HPI6") %>' />
                        <br />
                        LRNA:
                        <asp:TextBox ID="HPI7" Width="30" runat="server" ToolTip="Learning Approach" Text='<%# Bind("HPI7") %>' />
                    </td>
                    <td valign="top">
                        EXCI:
                        <asp:TextBox ID="HDS1" Width="30" runat="server" ToolTip="Excitable"  Text='<%# Bind("HDS1") %>' />
                        <br />
                        SKEP:
                        <asp:TextBox ID="HDS2" Width="30" runat="server" ToolTip="Skeptical" Text='<%# Bind("HDS2") %>' />
                        <br />
                        CAUT:
                        <asp:TextBox ID="HDS3" Width="30" runat="server" ToolTip="Cautious" Text='<%# Bind("HDS3") %>' />
                        <br />
                        RESE:
                        <asp:TextBox ID="HDS4" Width="30" runat="server" ToolTip="Reserved" Text='<%# Bind("HDS4") %>' />
                        <br />
                        LEIS:
                        <asp:TextBox ID="HDS5" Width="30" runat="server" ToolTip="Leisurely"  Text='<%# Bind("HDS5") %>' />
                        <br />
                        BOLD:
                        <asp:TextBox ID="HDS6" Width="30" runat="server" ToolTip="Bold"  Text='<%# Bind("HDS6") %>' />
                        <br />
                        MISC:
                        <asp:TextBox ID="HDS7" Width="30" runat="server" ToolTip="Mischievous" Text='<%# Bind("HDS7") %>' />
                        <br />
                        COLO:
                        <asp:TextBox ID="HDS8" Width="30" runat="server" ToolTip="Colorful" Text='<%# Bind("HDS8") %>' />
                        <br />
                        IMAG:
                        <asp:TextBox ID="HDS9" Width="30" runat="server" ToolTip="Imaginative" Text='<%# Bind("HDS9") %>' />
                        <br />
                        DILI:
                        <asp:TextBox ID="HDS10" Width="30" runat="server" ToolTip="Diligent" Text='<%# Bind("HDS10") %>' />
                        <br />
                        DUTI:
                        <asp:TextBox ID="HDS11" Width="30" runat="server" ToolTip="Dutiful" Text='<%# Bind("HDS11") %>' />
                    </td>
                    <td valign="top">
                        RECO:
                        <asp:TextBox ID="MVPI1" Width="30" runat="server" ToolTip="Recognition" Text='<%# Bind("MVPI1") %>' />
                        <br />
                        POWE:
                        <asp:TextBox ID="MVPI2" Width="30" runat="server" ToolTip="Power" Text='<%# Bind("MVPI2") %>' />
                        <br />
                        HEDO:
                        <asp:TextBox ID="MVPI3" Width="30" runat="server" ToolTip="Hedonism" Text='<%# Bind("MVPI3") %>' />
                        <br />
                        ALTR:
                        <asp:TextBox ID="MVPI4" Width="30" runat="server" ToolTip="Altruistic" Text='<%# Bind("MVPI4") %>' />
                        <br />
                        AFFI:
                        <asp:TextBox ID="MVPI5" Width="30" runat="server" ToolTip="Affiliation" Text='<%# Bind("MVPI5") %>' />
                        <br />
                        TRAD:
                        <asp:TextBox ID="MVPI6" Width="30" runat="server" ToolTip="Tradition" Text='<%# Bind("MVPI6") %>' />
                        <br />
                        SECU:
                        <asp:TextBox ID="MVPI7" Width="30" runat="server" ToolTip="Security" Text='<%# Bind("MVPI7") %>' />
                        <br />
                        COMM:
                        <asp:TextBox ID="MVPI8" Width="30" runat="server" ToolTip="Commerce" Text='<%# Bind("MVPI8") %>' />
                        <br />
                        AEST:
                        <asp:TextBox ID="MVPI9" Width="30" runat="server" ToolTip="Aesthetics" Text='<%# Bind("MVPI9") %>' />
                        <br />
                        SCIE:
                        <asp:TextBox ID="MVPI10" Width="30" runat="server" ToolTip="Science" Text='<%# Bind("MVPI10") %>' />
                    </td>
                    <td valign="top">
                        Strat. Clarity:
                        <asp:TextBox ID="LF1" Width="30" runat="server" Text='<%# Bind("LF1") %>' />
                        <br />
                        Exec. Savvy:
                        <asp:TextBox ID="LF2" Width="30" runat="server" Text='<%# Bind("LF2") %>' />
                        <br />
                        Res. and Adapt.:
                        <asp:TextBox ID="LF3" Width="30" runat="server" Text='<%# Bind("LF3") %>' />
                        <br />
                        Stakeholder Mgmt:
                        <asp:TextBox ID="LF4" Width="30" runat="server" Text='<%# Bind("LF4") %>' />
                        <br />
                        Ppl and Team Dev.:
                        <asp:TextBox ID="LF5" Width="30" runat="server" Text='<%# Bind("LF5") %>' />
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="0" style="border: 1px solid maroon;">
                            <tr>
                                <td valign="top" align="right">
                                    HPIs1:
                                    <asp:TextBox ID="spacer" Width="30" runat="server" Text="NA" Enabled="false" />
                                    <br />
                                    HPIs2:
                                    <asp:TextBox ID="HPIs2" Width="30" runat="server" Text='<%# Bind("HPIs2") %>' />
                                    <br />
                                    HPIs3:
                                    <asp:TextBox ID="HPIs3" Width="30" runat="server" Text='<%# Bind("HPIs3") %>' />
                                    <br />
                                    HPIs4:
                                    <asp:TextBox ID="HPIs4" Width="30" runat="server" Text='<%# Bind("HPIs4") %>' />
                                    <br />
                                    HPIs5:
                                    <asp:TextBox ID="HPIs5" Width="30" runat="server" Text='<%# Bind("HPIs5") %>' />
                                    <br />
                                    HPIs6:
                                    <asp:TextBox ID="HPIs6" Width="30" runat="server" Text='<%# Bind("HPIs6") %>' />
                                    <br />
                                    HPIs7:
                                    <asp:TextBox ID="HPIs7" Width="30" runat="server" Text='<%# Bind("HPIs7") %>' />
                                    <br />
                                    HPIs8:
                                    <asp:TextBox ID="HPIs8" Width="30" runat="server" Text='<%# Bind("HPIs8") %>' />
                                    <br />
                                    HPIs9:
                                    <asp:TextBox ID="HPIs9" Width="30" runat="server" Text='<%# Bind("HPIs9") %>' />
                                    <br />
                                    HPIs10:
                                    <asp:TextBox ID="HPIs10" Width="30" runat="server" Text='<%# Bind("HPIs10") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs11:
                                    <asp:TextBox ID="HPIs11" Width="30" runat="server" Text='<%# Bind("HPIs11") %>' />
                                    <br />
                                    HPIs12:
                                    <asp:TextBox ID="HPIs12" Width="30" runat="server" Text='<%# Bind("HPIs12") %>' />
                                    <br />
                                    HPIs13:
                                    <asp:TextBox ID="HPIs13" Width="30" runat="server" Text='<%# Bind("HPIs13") %>' />
                                    <br />
                                    HPIs14:
                                    <asp:TextBox ID="HPIs14" Width="30" runat="server" Text='<%# Bind("HPIs14") %>' />
                                    <br />
                                    HPIs15:
                                    <asp:TextBox ID="HPIs15" Width="30" runat="server" Text='<%# Bind("HPIs15") %>' />
                                    <br />
                                    HPIs16:
                                    <asp:TextBox ID="HPIs16" Width="30" runat="server" Text='<%# Bind("HPIs16") %>' />
                                    <br />
                                    HPIs17:
                                    <asp:TextBox ID="HPIs17" Width="30" runat="server" Text='<%# Bind("HPIs17") %>' />
                                    <br />
                                    HPIs18:
                                    <asp:TextBox ID="HPIs18" Width="30" runat="server" Text='<%# Bind("HPIs18") %>' />
                                    <br />
                                    HPIs19:
                                    <asp:TextBox ID="HPIs19" Width="30" runat="server" Text='<%# Bind("HPIs19") %>' />
                                    <br />
                                    HPIs20:
                                    <asp:TextBox ID="HPIs20" Width="30" runat="server" Text='<%# Bind("HPIs20") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs21:
                                    <asp:TextBox ID="HPIs21" Width="30" runat="server" Text='<%# Bind("HPIs21") %>' />
                                    <br />
                                    HPIs22:
                                    <asp:TextBox ID="HPIs22" Width="30" runat="server" Text='<%# Bind("HPIs22") %>' />
                                    <br />
                                    HPIs23:
                                    <asp:TextBox ID="HPIs23" Width="30" runat="server" Text='<%# Bind("HPIs23") %>' />
                                    <br />
                                    HPIs24:
                                    <asp:TextBox ID="HPIs24" Width="30" runat="server" Text='<%# Bind("HPIs24") %>' />
                                    <br />
                                    HPIs25:
                                    <asp:TextBox ID="HPIs25" Width="30" runat="server" Text='<%# Bind("HPIs25") %>' />
                                    <br />
                                    HPIs26:
                                    <asp:TextBox ID="HPIs26" Width="30" runat="server" Text='<%# Bind("HPIs26") %>' />
                                    <br />
                                    HPIs27:
                                    <asp:TextBox ID="HPIs27" Width="30" runat="server" Text='<%# Bind("HPIs27") %>' />
                                    <br />
                                    HPIs28:
                                    <asp:TextBox ID="HPIs28" Width="30" runat="server" Text='<%# Bind("HPIs28") %>' />
                                    <br />
                                    HPIs29:
                                    <asp:TextBox ID="HPIs29" Width="30" runat="server" Text='<%# Bind("HPIs29") %>' />
                                    <br />
                                    HPIs30:
                                    <asp:TextBox ID="HPIs30" Width="30" runat="server" Text='<%# Bind("HPIs30") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs31:
                                    <asp:TextBox ID="HPIs31" Width="30" runat="server" Text='<%# Bind("HPIs31") %>' />
                                    <br />
                                    HPIs32:
                                    <asp:TextBox ID="HPIs32" Width="30" runat="server" Text='<%# Bind("HPIs32") %>' />
                                    <br />
                                    HPIs33:
                                    <asp:TextBox ID="HPIs33" Width="30" runat="server" Text='<%# Bind("HPIs33") %>' />
                                    <br />
                                    HPIs34:
                                    <asp:TextBox ID="HPIs34" Width="30" runat="server" Text='<%# Bind("HPIs34") %>' />
                                    <br />
                                    HPIs35:
                                    <asp:TextBox ID="HPIs35" Width="30" runat="server" Text='<%# Bind("HPIs35") %>' />
                                    <br />
                                    HPIs36:
                                    <asp:TextBox ID="HPIs36" Width="30" runat="server" Text='<%# Bind("HPIs36") %>' />
                                    <br />
                                    HPIs37:
                                    <asp:TextBox ID="HPIs37" Width="30" runat="server" Text='<%# Bind("HPIs37") %>' />
                                    <br />
                                    HPIs38:
                                    <asp:TextBox ID="HPIs38" Width="30" runat="server" Text='<%# Bind("HPIs38") %>' />
                                    <br />
                                    HPIs39:
                                    <asp:TextBox ID="HPIs39" Width="30" runat="server" Text='<%# Bind("HPIs39") %>' />
                                    <br />
                                    HPIs40:
                                    <asp:TextBox ID="HPIs40" Width="30" runat="server" Text='<%# Bind("HPIs40") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs41:
                                    <asp:TextBox ID="HPIs41" Width="30" runat="server" Text='<%# Bind("HPIs41") %>' />
                                    <br />
                                    HPIs42:
                                    <asp:TextBox ID="HPIs42" Width="30" runat="server" Text='<%# Bind("HPIs42") %>' />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="0" style="border: 1px solid maroon;">
                            <tr>
                                <td valign="top" align="right">
                                    HDSs1:
                                    <asp:TextBox ID="HDSs1" Width="30" runat="server" Text='<%# Bind("HDSs1")%>' />
                                    <br />
                                     HDSs2:
                                    <asp:TextBox ID="HDSs2" Width="30" runat="server" Text='<%# Bind("HDSs2")%>' />
                                    <br />
                                     HDSs3:
                                    <asp:TextBox ID="HDSs3" Width="30" runat="server" Text='<%# Bind("HDSs3")%>' />
                                    <br />
                                     HDSs4:
                                    <asp:TextBox ID="HDSs4" Width="30" runat="server" Text='<%# Bind("HDSs4")%>' />
                                    <br />
                                     HDSs5:
                                    <asp:TextBox ID="HDSs5" Width="30" runat="server" Text='<%# Bind("HDSs5")%>' />
                                    <br />
                                     HDSs6:
                                    <asp:TextBox ID="HDSs6" Width="30" runat="server" Text='<%# Bind("HDSs6")%>' />
                                    <br />
                                     HDSs7:
                                    <asp:TextBox ID="HDSs7" Width="30" runat="server" Text='<%# Bind("HDSs7")%>' />
                                    <br />
                                     HDSs8:
                                    <asp:TextBox ID="HDSs8" Width="30" runat="server" Text='<%# Bind("HDSs8")%>' />
                                    <br />
                                     HDSs9:
                                    <asp:TextBox ID="HDSs9" Width="30" runat="server" Text='<%# Bind("HDSs9")%>' />
                                    <br />
                                     HDSs10:
                                    <asp:TextBox ID="HDSs10" Width="30" runat="server" Text='<%# Bind("HDSs10")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    HDSs11:
                                    <asp:TextBox ID="HDSs11" Width="30" runat="server" Text='<%# Bind("HDSs11")%>' />
                                    <br />
                                     HDSs12:
                                    <asp:TextBox ID="HDSs12" Width="30" runat="server" Text='<%# Bind("HDSs12")%>' />
                                    <br />
                                     HDSs13:
                                    <asp:TextBox ID="HDSs13" Width="30" runat="server" Text='<%# Bind("HDSs13")%>' />
                                    <br />
                                     HDSs14:
                                    <asp:TextBox ID="HDSs14" Width="30" runat="server" Text='<%# Bind("HDSs14")%>' />
                                    <br />
                                     HDSs15:
                                    <asp:TextBox ID="HDSs15" Width="30" runat="server" Text='<%# Bind("HDSs15")%>' />
                                    <br />
                                     HDSs16:
                                    <asp:TextBox ID="HDSs16" Width="30" runat="server" Text='<%# Bind("HDSs16")%>' />
                                    <br />
                                     HDSs17:
                                    <asp:TextBox ID="HDSs17" Width="30" runat="server" Text='<%# Bind("HDSs17")%>' />
                                    <br />
                                     HDSs18:
                                    <asp:TextBox ID="HDSs18" Width="30" runat="server" Text='<%# Bind("HDSs18")%>' />
                                    <br />
                                     HDSs19:
                                    <asp:TextBox ID="HDSs19" Width="30" runat="server" Text='<%# Bind("HDSs19")%>' />
                                    <br />
                                     HDSs20:
                                    <asp:TextBox ID="HDSs20" Width="30" runat="server" Text='<%# Bind("HDSs20")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    HDSs21:
                                    <asp:TextBox ID="HDSs21" Width="30" runat="server" Text='<%# Bind("HDSs21")%>' />
                                    <br />
                                     HDSs22:
                                    <asp:TextBox ID="HDSs22" Width="30" runat="server" Text='<%# Bind("HDSs22")%>' />
                                    <br />
                                     HDSs23:
                                    <asp:TextBox ID="HDSs23" Width="30" runat="server" Text='<%# Bind("HDSs23")%>' />
                                    <br />
                                     HDSs24:
                                    <asp:TextBox ID="HDSs24" Width="30" runat="server" Text='<%# Bind("HDSs24")%>' />
                                    <br />
                                     HDSs25:
                                    <asp:TextBox ID="HDSs25" Width="30" runat="server" Text='<%# Bind("HDSs25")%>' />
                                    <br />
                                     HDSs26:
                                    <asp:TextBox ID="HDSs26" Width="30" runat="server" Text='<%# Bind("HDSs26")%>' />
                                    <br />
                                     HDSs27:
                                    <asp:TextBox ID="HDSs27" Width="30" runat="server" Text='<%# Bind("HDSs27")%>' />
                                    <br />
                                     HDSs28:
                                    <asp:TextBox ID="HDSs28" Width="30" runat="server" Text='<%# Bind("HDSs28")%>' />
                                    <br />
                                     HDSs29:
                                    <asp:TextBox ID="HDSs29" Width="30" runat="server" Text='<%# Bind("HDSs29")%>' />
                                    <br />
                                     HDSs30:
                                    <asp:TextBox ID="HDSs30" Width="30" runat="server" Text='<%# Bind("HDSs30")%>' />
                                    <br />
                                </td>

                                 <td valign="top" align="right">
                                    HDSs31:
                                    <asp:TextBox ID="HDSs31" Width="30" runat="server" Text='<%# Bind("HDSs31")%>' />
                                    <br />
                                     HDSs32:
                                    <asp:TextBox ID="HDSs32" Width="30" runat="server" Text='<%# Bind("HDSs32")%>' />
                                    <br />
                                     HDSs33:
                                    <asp:TextBox ID="HDSs33" Width="30" runat="server" Text='<%# Bind("HDSs33")%>' />
                                    <br />
                                    
                                </td>

                            </tr>
                        </table>
                    </td>


                     <td valign="top">
                        <table cellpadding="2" cellspacing="0" style="border: 1px solid maroon;">
                            <tr>
                                <td valign="top" align="right">
                                    MVPIs1:
                                    <asp:TextBox ID="MVPIs1" Width="30" runat="server" Text='<%# Bind("MVPIs1")%>' />
                                    <br />
                                     MVPIs2:
                                    <asp:TextBox ID="MVPIs2" Width="30" runat="server" Text='<%# Bind("MVPIs2")%>' />
                                    <br />
                                     MVPIs3:
                                    <asp:TextBox ID="MVPIs3" Width="30" runat="server" Text='<%# Bind("MVPIs3")%>' />
                                    <br />
                                     MVPIs4:
                                    <asp:TextBox ID="MVPIs4" Width="30" runat="server" Text='<%# Bind("MVPIs4")%>' />
                                    <br />
                                     MVPIs5:
                                    <asp:TextBox ID="MVPIs5" Width="30" runat="server" Text='<%# Bind("MVPIs5")%>' />
                                    <br />
                                     MVPIs6:
                                    <asp:TextBox ID="MVPIs6" Width="30" runat="server" Text='<%# Bind("MVPIs6")%>' />
                                    <br />
                                     MVPIs7:
                                    <asp:TextBox ID="MVPIs7" Width="30" runat="server" Text='<%# Bind("MVPIs7")%>' />
                                    <br />
                                     MVPIs8:
                                    <asp:TextBox ID="MVPIs8" Width="30" runat="server" Text='<%# Bind("MVPIs8")%>' />
                                    <br />
                                     MVPIs9:
                                    <asp:TextBox ID="MVPIs9" Width="30" runat="server" Text='<%# Bind("MVPIs9")%>' />
                                    <br />
                                     MVPIs10:
                                    <asp:TextBox ID="MVPIs10" Width="30" runat="server" Text='<%# Bind("MVPIs10")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    MVPIs11:
                                    <asp:TextBox ID="MVPIs11" Width="30" runat="server" Text='<%# Bind("MVPIs11")%>' />
                                    <br />
                                     MVPIs12:
                                    <asp:TextBox ID="MVPIs12" Width="30" runat="server" Text='<%# Bind("MVPIs12")%>' />
                                    <br />
                                     MVPIs13:
                                    <asp:TextBox ID="MVPIs13" Width="30" runat="server" Text='<%# Bind("MVPIs13")%>' />
                                    <br />
                                     MVPIs14:
                                    <asp:TextBox ID="MVPIs14" Width="30" runat="server" Text='<%# Bind("MVPIs14")%>' />
                                    <br />
                                     MVPIs15:
                                    <asp:TextBox ID="MVPIs15" Width="30" runat="server" Text='<%# Bind("MVPIs15")%>' />
                                    <br />
                                     MVPIs16:
                                    <asp:TextBox ID="MVPIs16" Width="30" runat="server" Text='<%# Bind("MVPIs16")%>' />
                                    <br />
                                     MVPIs17:
                                    <asp:TextBox ID="MVPIs17" Width="30" runat="server" Text='<%# Bind("MVPIs17")%>' />
                                    <br />
                                     MVPIs18:
                                    <asp:TextBox ID="MVPIs18" Width="30" runat="server" Text='<%# Bind("MVPIs18")%>' />
                                    <br />
                                     MVPIs19:
                                    <asp:TextBox ID="MVPIs19" Width="30" runat="server" Text='<%# Bind("MVPIs19")%>' />
                                    <br />
                                     MVPIs20:
                                    <asp:TextBox ID="MVPIs20" Width="30" runat="server" Text='<%# Bind("MVPIs20")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    MVPIs21:
                                    <asp:TextBox ID="MVPIs21" Width="30" runat="server" Text='<%# Bind("MVPIs21")%>' />
                                    <br />
                                     MVPIs22:
                                    <asp:TextBox ID="MVPIs22" Width="30" runat="server" Text='<%# Bind("MVPIs22")%>' />
                                    <br />
                                     MVPIs23:
                                    <asp:TextBox ID="MVPIs23" Width="30" runat="server" Text='<%# Bind("MVPIs23")%>' />
                                    <br />
                                     MVPIs24:
                                    <asp:TextBox ID="MVPIs24" Width="30" runat="server" Text='<%# Bind("MVPIs24")%>' />
                                    <br />
                                     MVPIs25:
                                    <asp:TextBox ID="MVPIs25" Width="30" runat="server" Text='<%# Bind("MVPIs25")%>' />
                                    <br />
                                     MVPIs26:
                                    <asp:TextBox ID="MVPIs26" Width="30" runat="server" Text='<%# Bind("MVPIs26")%>' />
                                    <br />
                                     MVPIs27:
                                    <asp:TextBox ID="MVPIs27" Width="30" runat="server" Text='<%# Bind("MVPIs27")%>' />
                                    <br />
                                     MVPIs28:
                                    <asp:TextBox ID="MVPIs28" Width="30" runat="server" Text='<%# Bind("MVPIs28")%>' />
                                    <br />
                                     MVPIs29:
                                    <asp:TextBox ID="MVPIs29" Width="30" runat="server" Text='<%# Bind("MVPIs29")%>' />
                                    <br />
                                     MVPIs30:
                                    <asp:TextBox ID="MVPIs30" Width="30" runat="server" Text='<%# Bind("MVPIs30")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    MVPIs31:
                                    <asp:TextBox ID="MVPIs31" Width="30" runat="server" Text='<%# Bind("MVPIs31")%>' />
                                    <br />
                                     MVPIs32:
                                    <asp:TextBox ID="MVPIs32" Width="30" runat="server" Text='<%# Bind("MVPIs32")%>' />
                                    <br />
                                     MVPIs33:
                                    <asp:TextBox ID="MVPIs33" Width="30" runat="server" Text='<%# Bind("MVPIs33")%>' />
                                    <br />
                                     MVPIs34:
                                    <asp:TextBox ID="MVPIs34" Width="30" runat="server" Text='<%# Bind("MVPIs34")%>' />
                                    <br />
                                     MVPIs35:
                                    <asp:TextBox ID="MVPIs35" Width="30" runat="server" Text='<%# Bind("MVPIs35")%>' />
                                    <br />
                                     MVPIs36:
                                    <asp:TextBox ID="MVPIs36" Width="30" runat="server" Text='<%# Bind("MVPIs36")%>' />
                                    <br />
                                     MVPIs37:
                                    <asp:TextBox ID="MVPIs37" Width="30" runat="server" Text='<%# Bind("MVPIs37")%>' />
                                    <br />
                                     MVPIs38:
                                    <asp:TextBox ID="MVPIs38" Width="30" runat="server" Text='<%# Bind("MVPIs38")%>' />
                                    <br />
                                     MVPIs39:
                                    <asp:TextBox ID="MVPIs39" Width="30" runat="server" Text='<%# Bind("MVPIs39")%>' />
                                    <br />
                                     MVPIs40:
                                    <asp:TextBox ID="MVPIs40" Width="30" runat="server" Text='<%# Bind("MVPIs40")%>' />
                                    <br />
                                </td>

                                <td valign="top" align="right">
                                    MVPIs41:
                                    <asp:TextBox ID="MVPIs41" Width="30" runat="server" Text='<%# Bind("MVPIs41")%>' />
                                    <br />
                                     MVPIs42:
                                    <asp:TextBox ID="MVPIs42" Width="30" runat="server" Text='<%# Bind("MVPIs42")%>' />
                                    <br />
                                     MVPIs43:
                                    <asp:TextBox ID="MVPIs43" Width="30" runat="server" Text='<%# Bind("MVPIs43")%>' />
                                    <br />
                                     MVPIs44:
                                    <asp:TextBox ID="MVPIs44" Width="30" runat="server" Text='<%# Bind("MVPIs44")%>' />
                                    <br />
                                     MVPIs45:
                                    <asp:TextBox ID="MVPIs45" Width="30" runat="server" Text='<%# Bind("MVPIs45")%>' />
                                    <br />
                                     MVPIs46:
                                    <asp:TextBox ID="MVPIs46" Width="30" runat="server" Text='<%# Bind("MVPIs46")%>' />
                                    <br />
                                     MVPIs47:
                                    <asp:TextBox ID="MVPIs47" Width="30" runat="server" Text='<%# Bind("MVPIs47")%>' />
                                    <br />
                                     MVPIs48:
                                    <asp:TextBox ID="MVPIs48" Width="30" runat="server" Text='<%# Bind("MVPIs48")%>' />
                                    <br />
                                     MVPIs49:
                                    <asp:TextBox ID="MVPIs49" Width="30" runat="server" Text='<%# Bind("MVPIs49")%>' />
                                    <br />
                                     MVPIs50:
                                    <asp:TextBox ID="MVPIs50" Width="30" runat="server" Text='<%# Bind("MVPIs50")%>' />
                                    <br />
                                </td>

                            </tr>
                        </table>
                    </td>

                </tr>
            </table>
            <br />
            <center>
                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update" />
                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="Cancel" />
                &nbsp;<asp:Button ID="btnCalc" runat="server" CausesValidation="False" CommandName="Calc"
                    Text="Calculate" /></center>
        </EditItemTemplate>
    </asp:FormView>
</asp:Content>
