namespace turingMaschine
{
    partial class Form1
    {
        /// <summary>
        /// Erforderliche Designervariable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Verwendete Ressourcen bereinigen.
        /// </summary>
        /// <param name="disposing">True, wenn verwaltete Ressourcen gelöscht werden sollen; andernfalls False.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Vom Windows Form-Designer generierter Code

        /// <summary>
        /// Erforderliche Methode für die Designerunterstützung.
        /// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStepsLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStateLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.buttonRun = new System.Windows.Forms.ToolStripButton();
            this.buttonStepRun = new System.Windows.Forms.ToolStripButton();
            this.buttonRefresh = new System.Windows.Forms.ToolStripButton();
            this.buttonStepBackwards = new System.Windows.Forms.ToolStripButton();
            this.buttonStepForward = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.buttonNewFile = new System.Windows.Forms.ToolStripButton();
            this.buttonSaveAs = new System.Windows.Forms.ToolStripButton();
            this.buttonSave = new System.Windows.Forms.ToolStripButton();
            this.buttonOpenFile = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.buttonAddRow = new System.Windows.Forms.ToolStripButton();
            this.buttonRowRemove = new System.Windows.Forms.ToolStripButton();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.labelBlank = new System.Windows.Forms.Label();
            this.textBoxBlank = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.labelInput = new System.Windows.Forms.Label();
            this.textBoxInput = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.labelAlphabet = new System.Windows.Forms.Label();
            this.textBoxAlphabet = new System.Windows.Forms.TextBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.textBoxDesc = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.textBoxAuthor = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.textBoxPName = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.panel3 = new System.Windows.Forms.Panel();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.label1 = new System.Windows.Forms.Label();
            this.elementHost1 = new System.Windows.Forms.Integration.ElementHost();
            this.userControl12 = new WpfControlLibrary1.UserControl1();
            this.statusStrip1.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.tabPage2.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.SuspendLayout();
            // 
            // statusStrip1
            // 
            this.statusStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStepsLabel,
            this.toolStripStateLabel});
            this.statusStrip1.Location = new System.Drawing.Point(0, 395);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(557, 22);
            this.statusStrip1.TabIndex = 1;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStepsLabel
            // 
            this.toolStripStepsLabel.Name = "toolStripStepsLabel";
            this.toolStripStepsLabel.Size = new System.Drawing.Size(118, 17);
            this.toolStripStepsLabel.Text = "toolStripStatusLabel1";
            // 
            // toolStripStateLabel
            // 
            this.toolStripStateLabel.Name = "toolStripStateLabel";
            this.toolStripStateLabel.Size = new System.Drawing.Size(118, 17);
            this.toolStripStateLabel.Text = "toolStripStatusLabel2";
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.buttonRun,
            this.buttonStepRun,
            this.buttonRefresh,
            this.buttonStepBackwards,
            this.buttonStepForward,
            this.toolStripSeparator1,
            this.buttonNewFile,
            this.buttonSaveAs,
            this.buttonSave,
            this.buttonOpenFile,
            this.toolStripSeparator2,
            this.buttonAddRow,
            this.buttonRowRemove});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Padding = new System.Windows.Forms.Padding(0, 0, 2, 0);
            this.toolStrip1.Size = new System.Drawing.Size(557, 25);
            this.toolStrip1.TabIndex = 2;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // buttonRun
            // 
            this.buttonRun.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonRun.Image = global::qLearning.Properties.Resources.Run_16x;
            this.buttonRun.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonRun.Name = "buttonRun";
            this.buttonRun.Size = new System.Drawing.Size(23, 22);
            // 
            // buttonStepRun
            // 
            this.buttonStepRun.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonStepRun.Image = global::qLearning.Properties.Resources.PlayStep_16x;
            this.buttonStepRun.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonStepRun.Name = "buttonStepRun";
            this.buttonStepRun.Size = new System.Drawing.Size(23, 22);
            // 
            // buttonRefresh
            // 
            this.buttonRefresh.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonRefresh.Image = global::qLearning.Properties.Resources.Refresh_16x;
            this.buttonRefresh.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonRefresh.Name = "buttonRefresh";
            this.buttonRefresh.Size = new System.Drawing.Size(23, 22);
            this.buttonRefresh.Click += new System.EventHandler(this.ButtonRefresh_Click);
            // 
            // buttonStepBackwards
            // 
            this.buttonStepBackwards.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonStepBackwards.Image = global::qLearning.Properties.Resources.StepBackwards_16x;
            this.buttonStepBackwards.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonStepBackwards.Name = "buttonStepBackwards";
            this.buttonStepBackwards.Size = new System.Drawing.Size(23, 22);
            this.buttonStepBackwards.Text = "toolStripButton3";
            this.buttonStepBackwards.Click += new System.EventHandler(this.ButtonStepBackwards_Click);
            // 
            // buttonStepForward
            // 
            this.buttonStepForward.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonStepForward.Image = global::qLearning.Properties.Resources.StepForward_16x;
            this.buttonStepForward.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonStepForward.Name = "buttonStepForward";
            this.buttonStepForward.Size = new System.Drawing.Size(23, 22);
            this.buttonStepForward.Text = "toolStripButton4";
            this.buttonStepForward.Click += new System.EventHandler(this.ButtonStepForward_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // buttonNewFile
            // 
            this.buttonNewFile.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonNewFile.Image = global::qLearning.Properties.Resources.NewFile_16x;
            this.buttonNewFile.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonNewFile.Name = "buttonNewFile";
            this.buttonNewFile.Size = new System.Drawing.Size(23, 22);
            this.buttonNewFile.Text = "toolStripButton5";
            // 
            // buttonSaveAs
            // 
            this.buttonSaveAs.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonSaveAs.Image = global::qLearning.Properties.Resources.SaveAs_16x;
            this.buttonSaveAs.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonSaveAs.Name = "buttonSaveAs";
            this.buttonSaveAs.Size = new System.Drawing.Size(23, 22);
            this.buttonSaveAs.Text = "toolStripButton6";
            // 
            // buttonSave
            // 
            this.buttonSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonSave.Image = global::qLearning.Properties.Resources.Save_16x;
            this.buttonSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonSave.Name = "buttonSave";
            this.buttonSave.Size = new System.Drawing.Size(23, 22);
            this.buttonSave.Text = "toolStripButton7";
            // 
            // buttonOpenFile
            // 
            this.buttonOpenFile.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonOpenFile.Image = global::qLearning.Properties.Resources.OpenFolder_16x;
            this.buttonOpenFile.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonOpenFile.Name = "buttonOpenFile";
            this.buttonOpenFile.Size = new System.Drawing.Size(23, 22);
            this.buttonOpenFile.Text = "toolStripButton8";
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // buttonAddRow
            // 
            this.buttonAddRow.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonAddRow.Image = global::qLearning.Properties.Resources.AddRow_16x;
            this.buttonAddRow.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonAddRow.Name = "buttonAddRow";
            this.buttonAddRow.Size = new System.Drawing.Size(23, 22);
            this.buttonAddRow.Text = "toolStripButton9";
            this.buttonAddRow.Click += new System.EventHandler(this.ButtonAddRow_Click);
            // 
            // buttonRowRemove
            // 
            this.buttonRowRemove.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.buttonRowRemove.Image = global::qLearning.Properties.Resources.RemoveRow_16x;
            this.buttonRowRemove.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.buttonRowRemove.Name = "buttonRowRemove";
            this.buttonRowRemove.Size = new System.Drawing.Size(23, 22);
            this.buttonRowRemove.Text = "toolStripButton10";
            this.buttonRowRemove.Click += new System.EventHandler(this.ButtonRowRemove_Click);
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel1.Controls.Add(this.tabControl1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.label1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.elementHost1, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 25);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(557, 370);
            this.tableLayoutPanel1.TabIndex = 3;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(3, 3);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(551, 289);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.splitContainer1);
            this.tabPage1.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(543, 263);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Turingmachine";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // splitContainer1
            // 
            this.splitContainer1.BackColor = System.Drawing.Color.Transparent;
            this.splitContainer1.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
            this.splitContainer1.Location = new System.Drawing.Point(3, 3);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.BackColor = System.Drawing.Color.Transparent;
            this.splitContainer1.Panel1.Controls.Add(this.groupBox3);
            this.splitContainer1.Panel1.Controls.Add(this.groupBox2);
            this.splitContainer1.Panel1.Controls.Add(this.groupBox1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.BackColor = System.Drawing.Color.Transparent;
            this.splitContainer1.Panel2.Controls.Add(this.dataGridView1);
            this.splitContainer1.Size = new System.Drawing.Size(537, 257);
            this.splitContainer1.SplitterDistance = 201;
            this.splitContainer1.TabIndex = 0;
            // 
            // groupBox3
            // 
            this.groupBox3.AutoSize = true;
            this.groupBox3.Controls.Add(this.labelBlank);
            this.groupBox3.Controls.Add(this.textBoxBlank);
            this.groupBox3.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox3.Location = new System.Drawing.Point(0, 104);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(201, 52);
            this.groupBox3.TabIndex = 2;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Blank";
            // 
            // labelBlank
            // 
            this.labelBlank.AutoSize = true;
            this.labelBlank.Dock = System.Windows.Forms.DockStyle.Top;
            this.labelBlank.Location = new System.Drawing.Point(3, 36);
            this.labelBlank.Name = "labelBlank";
            this.labelBlank.Size = new System.Drawing.Size(0, 13);
            this.labelBlank.TabIndex = 1;
            // 
            // textBoxBlank
            // 
            this.textBoxBlank.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxBlank.Location = new System.Drawing.Point(3, 16);
            this.textBoxBlank.Name = "textBoxBlank";
            this.textBoxBlank.Size = new System.Drawing.Size(195, 20);
            this.textBoxBlank.TabIndex = 0;
            this.textBoxBlank.Text = "#";
            this.textBoxBlank.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxBlank_KeyPress);
            // 
            // groupBox2
            // 
            this.groupBox2.AutoSize = true;
            this.groupBox2.Controls.Add(this.labelInput);
            this.groupBox2.Controls.Add(this.textBoxInput);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox2.Location = new System.Drawing.Point(0, 52);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(201, 52);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Input word";
            // 
            // labelInput
            // 
            this.labelInput.AutoSize = true;
            this.labelInput.Dock = System.Windows.Forms.DockStyle.Top;
            this.labelInput.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelInput.ForeColor = System.Drawing.Color.Red;
            this.labelInput.Location = new System.Drawing.Point(3, 36);
            this.labelInput.Name = "labelInput";
            this.labelInput.Size = new System.Drawing.Size(0, 13);
            this.labelInput.TabIndex = 1;
            // 
            // textBoxInput
            // 
            this.textBoxInput.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxInput.Location = new System.Drawing.Point(3, 16);
            this.textBoxInput.Name = "textBoxInput";
            this.textBoxInput.Size = new System.Drawing.Size(195, 20);
            this.textBoxInput.TabIndex = 0;
            this.textBoxInput.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxInput_KeyPress);
            // 
            // groupBox1
            // 
            this.groupBox1.AutoSize = true;
            this.groupBox1.Controls.Add(this.labelAlphabet);
            this.groupBox1.Controls.Add(this.textBoxAlphabet);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox1.Location = new System.Drawing.Point(0, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(201, 52);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Alphabet";
            // 
            // labelAlphabet
            // 
            this.labelAlphabet.AutoSize = true;
            this.labelAlphabet.Dock = System.Windows.Forms.DockStyle.Top;
            this.labelAlphabet.Location = new System.Drawing.Point(3, 36);
            this.labelAlphabet.Name = "labelAlphabet";
            this.labelAlphabet.Size = new System.Drawing.Size(0, 13);
            this.labelAlphabet.TabIndex = 1;
            // 
            // textBoxAlphabet
            // 
            this.textBoxAlphabet.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxAlphabet.Location = new System.Drawing.Point(3, 16);
            this.textBoxAlphabet.Name = "textBoxAlphabet";
            this.textBoxAlphabet.Size = new System.Drawing.Size(195, 20);
            this.textBoxAlphabet.TabIndex = 0;
            this.textBoxAlphabet.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxAlphabet_KeyPress);
            this.textBoxAlphabet.Leave += new System.EventHandler(this.TextBoxAlphabet_Leave);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToResizeRows = false;
            this.dataGridView1.BackgroundColor = System.Drawing.SystemColors.Control;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.dataGridView1.Location = new System.Drawing.Point(0, 0);
            this.dataGridView1.MultiSelect = false;
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.CellSelect;
            this.dataGridView1.Size = new System.Drawing.Size(332, 257);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.DoubleClick += new System.EventHandler(this.DataGridView1_DoubleClick);
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.linkLabel1);
            this.tabPage2.Controls.Add(this.label9);
            this.tabPage2.Controls.Add(this.label8);
            this.tabPage2.Controls.Add(this.groupBox4);
            this.tabPage2.Cursor = System.Windows.Forms.Cursors.Default;
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(543, 263);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Info";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // linkLabel1
            // 
            this.linkLabel1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Location = new System.Drawing.Point(503, 247);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.linkLabel1.Size = new System.Drawing.Size(40, 13);
            this.linkLabel1.TabIndex = 3;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "GitHub";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LinkLabel1_LinkClicked);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.label9.Location = new System.Drawing.Point(3, 234);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(72, 13);
            this.label9.TabIndex = 2;
            this.label9.Text = "Version: 2.0.0";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.label8.Location = new System.Drawing.Point(3, 247);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(93, 13);
            this.label8.TabIndex = 1;
            this.label8.Text = "©2019 - Erik Spall";
            // 
            // groupBox4
            // 
            this.groupBox4.AutoSize = true;
            this.groupBox4.Controls.Add(this.textBoxDesc);
            this.groupBox4.Controls.Add(this.label7);
            this.groupBox4.Controls.Add(this.panel1);
            this.groupBox4.Controls.Add(this.textBoxAuthor);
            this.groupBox4.Controls.Add(this.label6);
            this.groupBox4.Controls.Add(this.panel2);
            this.groupBox4.Controls.Add(this.textBoxPName);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Controls.Add(this.panel3);
            this.groupBox4.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox4.Location = new System.Drawing.Point(3, 3);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(537, 143);
            this.groupBox4.TabIndex = 0;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Projectinfo";
            // 
            // textBoxDesc
            // 
            this.textBoxDesc.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxDesc.Location = new System.Drawing.Point(3, 120);
            this.textBoxDesc.Name = "textBoxDesc";
            this.textBoxDesc.Size = new System.Drawing.Size(531, 20);
            this.textBoxDesc.TabIndex = 5;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Dock = System.Windows.Forms.DockStyle.Top;
            this.label7.Location = new System.Drawing.Point(3, 107);
            this.label7.Margin = new System.Windows.Forms.Padding(3, 5, 3, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(89, 13);
            this.label7.TabIndex = 4;
            this.label7.Text = "Short description:";
            // 
            // panel1
            // 
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(3, 97);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(531, 10);
            this.panel1.TabIndex = 1;
            // 
            // textBoxAuthor
            // 
            this.textBoxAuthor.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxAuthor.Location = new System.Drawing.Point(3, 77);
            this.textBoxAuthor.Name = "textBoxAuthor";
            this.textBoxAuthor.Size = new System.Drawing.Size(531, 20);
            this.textBoxAuthor.TabIndex = 3;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Dock = System.Windows.Forms.DockStyle.Top;
            this.label6.Location = new System.Drawing.Point(3, 64);
            this.label6.Margin = new System.Windows.Forms.Padding(3, 5, 3, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(41, 13);
            this.label6.TabIndex = 2;
            this.label6.Text = "Author:";
            // 
            // panel2
            // 
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(3, 54);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(531, 10);
            this.panel2.TabIndex = 2;
            // 
            // textBoxPName
            // 
            this.textBoxPName.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxPName.Location = new System.Drawing.Point(3, 34);
            this.textBoxPName.Name = "textBoxPName";
            this.textBoxPName.Size = new System.Drawing.Size(531, 20);
            this.textBoxPName.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Dock = System.Windows.Forms.DockStyle.Top;
            this.label5.Location = new System.Drawing.Point(3, 21);
            this.label5.Margin = new System.Windows.Forms.Padding(3, 5, 3, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(75, 13);
            this.label5.TabIndex = 0;
            this.label5.Text = "Programname:";
            // 
            // panel3
            // 
            this.panel3.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel3.Location = new System.Drawing.Point(3, 16);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(531, 5);
            this.panel3.TabIndex = 2;
            // 
            // tabPage3
            // 
            this.tabPage3.Cursor = System.Windows.Forms.Cursors.Default;
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(543, 263);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Settings";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Image = global::qLearning.Properties.Resources.Arrowhead_Down_01_24__1_;
            this.label1.Location = new System.Drawing.Point(0, 295);
            this.label1.Margin = new System.Windows.Forms.Padding(0);
            this.label1.MaximumSize = new System.Drawing.Size(25, 25);
            this.label1.MinimumSize = new System.Drawing.Size(25, 25);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(25, 25);
            this.label1.TabIndex = 1;
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // elementHost1
            // 
            this.elementHost1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.elementHost1.Location = new System.Drawing.Point(0, 320);
            this.elementHost1.Margin = new System.Windows.Forms.Padding(0);
            this.elementHost1.Name = "elementHost1";
            this.elementHost1.Size = new System.Drawing.Size(557, 50);
            this.elementHost1.TabIndex = 2;
            this.elementHost1.Text = "elementHost1";
            this.elementHost1.Child = this.userControl12;
            // 
            // Form1
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.ClientSize = new System.Drawing.Size(557, 417);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.toolStrip1);
            this.Controls.Add(this.statusStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MinimumSize = new System.Drawing.Size(198, 144);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Turingmachine";
            this.Shown += new System.EventHandler(this.Form1_Shown);
            this.Click += new System.EventHandler(this.Form1_Click);
            this.Resize += new System.EventHandler(this.Form1_Resize);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton buttonRun;
        private System.Windows.Forms.ToolStripButton buttonStepRun;
        private System.Windows.Forms.ToolStripButton buttonRefresh;
        private System.Windows.Forms.ToolStripButton buttonStepBackwards;
        private System.Windows.Forms.ToolStripButton buttonStepForward;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton buttonNewFile;
        private System.Windows.Forms.ToolStripButton buttonSaveAs;
        private System.Windows.Forms.ToolStripButton buttonSave;
        private System.Windows.Forms.ToolStripButton buttonOpenFile;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton buttonAddRow;
        private System.Windows.Forms.ToolStripButton buttonRowRemove;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Integration.ElementHost elementHost1;
        private WpfControlLibrary1.UserControl1 userControl11;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStepsLabel;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label labelBlank;
        private System.Windows.Forms.TextBox textBoxBlank;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label labelInput;
        private System.Windows.Forms.TextBox textBoxInput;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label labelAlphabet;
        private System.Windows.Forms.TextBox textBoxAlphabet;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.TextBox textBoxDesc;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox textBoxAuthor;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox textBoxPName;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.LinkLabel linkLabel1;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStateLabel;
        private WpfControlLibrary1.UserControl1 userControl12;
    }
}

