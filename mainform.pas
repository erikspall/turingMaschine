unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, ComCtrls, PairSplitter, Math, Lists, inputDialog;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    Timer2: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ControlBar1Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1ChangeBounds(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure toggleMoveForward();
    procedure toggleMoveBackward();
    procedure Timer1Timer(Sender: TObject);
    procedure addPanelResize();
    procedure addPanel();
    procedure insertPanel();
    procedure removePanel();
    procedure FillPanelsWithContent();
  private

  public

  end;

var
  Form1: TForm1;
  band: TListofPanel;
  bandContent: TListofChar;
  i, pointer: integer;
  input: TForm2;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormShow(Sender: TObject);
var
  ttPanel: TPanel;
begin
  while (Form1.Width / 50) > band.Count() do
  begin
    ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := 296 - StatusBar1.Height;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := band.Count() * 50;
    ttPanel.Caption := '#';


    band.Add(ttPanel);
    bandContent.Add('#');
  end;

  band.getItem(((band.Count - 1) div 2) - 1).Color := clDefault;
  pointer := ((band.Count - 1) div 2);
  band.getItem((band.Count - 1) div 2).Color := Graphics.clHighlight;
end;

procedure TForm1.StringGrid1ChangeBounds(Sender: TObject);
begin
  Refresh();
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Dec(pointer);
  if pointer - (band.Count() div 2) < 0 then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.toggleMoveForward();
begin
  with Timer1 do
  begin
    if Enabled then
      Enabled := False
    else
      Enabled := True;
  end;
end;

procedure TForm1.toggleMoveBackward();
begin
  with Timer2 do
  begin
    if Enabled then
      Enabled := False
    else
      Enabled := True;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(pointer);
  if pointer + (band.Count() - 1 div 2) > bandContent.Count then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.addPanelResize();
var
  ttPanel: TPanel;
begin

  ttPanel := TPanel.Create(Form1);
  ttPanel.Parent := Form1;
  ttPanel.Top := 296 - StatusBar1.Height;
  ttPanel.Height := 50;
  ttPanel.Width := 50;
  ttPanel.Caption := '#';
  ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
  ttPanel.Anchors := ttPanel.Anchors - [akTop];

  if (frac(band.Count() / 2) = 0) then
  begin
    for i := 0 to band.Count - 1 do
    begin
      band.getItem(i).Left := band.getItem(i).Left + 50;
    end;
    if pointer - (band.Count() div 2) >= 0 then
      ttPanel.Caption := bandContent.getItem(pointer - (band.Count() div 2));
    ttPanel.Left := 0;
    band.insertItem(ttPanel, 0);

    Label1.Caption := pointer.toString;
    if bandContent.Count < band.Count then
    begin
      bandContent.insertItem('#', 0);
      Inc(pointer);
    end;
  end
  else
  begin

    ttPanel.Left := band.Count * 50;
    if pointer + (band.Count() div 2) < bandContent.Count then
      ttPanel.Caption := bandContent.getItem(pointer + (band.Count() div 2));
    band.Add(ttPanel);
    if bandContent.Count < band.Count then
      bandContent.Add('#');
  end;

end;

procedure TForm1.addPanel();
var
  ttPanel: TPanel;
begin

end;

procedure TForm1.insertPanel();
begin

end;

procedure TForm1.removePanel();
begin

end;

procedure TForm1.FillPanelsWithContent();
var
  j: integer;
begin
  if (frac(band.Count() / 2) = 0) then
  begin
    for i := 0 to band.Count() - 1 do
    begin
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2) + 1));
    end;
  end
  else
  begin
    for i := 0 to band.Count() - 1 do
    begin
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2)));
    end;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(Form2.ShowDialog());

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  toggleMoveForward();
end;

procedure TForm1.ControlBar1Click(Sender: TObject);
begin

end;

procedure TForm1.Edit1EditingDone(Sender: TObject); //Alphabet wurde eingegeben
var
  j: integer;
  t:String;
begin
  Edit1.Text := AnsiUpperCase(Edit1.Text);
   t:=Edit1.Text;
  if Length(Edit1.Text) > StringGrid1.ColCount then
  begin
    //Wenn die Länge Größer als Platz ist
   // ShowMessage(t);
    for i := 2 to StringGrid1.ColCount - 1 do
    begin

      for j := 1 to Length(Edit1.Text) do
      begin
      //  ShowMessage(t[j] + ' = ' + StringGrid1.Cols[i][0]);
        if t[j] = StringGrid1.Cols[i][0] then
        begin
          //ShowMessage('Das ist Korrekt');
          Delete(t, j, 1);

        end;
      end;
    end;
    //ShowMessage('Danach: ' + t);
    for i := 1 to Length(t) do
    begin
      if t[i] <> ',' then
      begin
        StringGrid1.ColCount := StringGrid1.ColCount + 1;
        StringGrid1.Cells[StringGrid1.ColCount - 1, 0] := t[i];


        end;

      end;


  end
  else if
  begin
  //...
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to Length(Edit2.Text) do
  begin
    if i + pointer - 1 >= bandContent.Count then
    begin
      bandContent.Add(Edit2.Text[i]);
      bandContent.insertItem('#', 0);
      Inc(pointer); //not sure about this
    end
    else
      bandContent.replaceItem(i + pointer - 1, Edit2.Text[i]);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.FormChangeBounds(Sender: TObject);

begin
  while (Form1.Width / 50) > band.Count() do
  begin
    addPanelResize();
  end;
  while ((Form1.Width / 50) + 1) < band.Count() do
  begin
    if not (frac(band.Count() / 2) = 0) then
    begin
      for i := 0 to band.Count() - 1 do
      begin
        band.getItem(i).Left := band.getItem(i).Left - 50;
      end;
      band.getItem(0).Destroy;

      Label1.Caption := pointer.toString;
      band.deleteItemAt(0);
    end
    else
    begin
      band.getItem(band.Count() - 1).Destroy;

      band.deleteItemAt(band.Count - 1);
    end;
  end;




  ListBox1.Clear;



  for i := 0 to bandContent.Count - 1 do
  begin
    ListBox1.Items.Add(bandContent.getItem(i));
  end;

  FillPanelsWithContent();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  band := TListOfPanel.Create;
  bandContent := TListOfChar.Create;

end;


end.
