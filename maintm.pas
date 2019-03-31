unit mainTM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  PairSplitter, Grids, StdCtrls, IniPropStorage, lists, inputDialogforTM,
  lclintf, LCLType, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckGroup1: TCheckGroup;
    CheckGroup2: TCheckGroup;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Image1: TImage;
    ImageList1: TImageList;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    settings: TIniPropStorage;
    Label4: TLabel;
    Label5: TLabel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tmInhalt: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure Edit3EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabeledEdit2EditingDone(Sender: TObject);
    procedure LabeledEdit3EditingDone(Sender: TObject);
    procedure LabeledEdit4EditingDone(Sender: TObject);
    procedure OpenDialog1Close(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SaveDialog1Close(Sender: TObject);
    procedure SpinEdit1EditingDone(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure einstellungenLesenUndSetzen();
    procedure moveForward();
    procedure initBand();
    procedure prepareBand();
    procedure moveBackward();
    procedure prepareStringGrid();
    procedure handleMove();
    function loadTM(FileName: string): boolean;
    procedure Timer1StopTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2StopTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3StartTimer(Sender: TObject);
    procedure Timer3StopTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure setViewMode(mode: integer);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  i: integer;
  finished: boolean;
  schritte: integer;
  animation: boolean = True;
  lastInputAl: string = '';
  lastInputEin: string = '';
  breite: integer;
  hasMoved: boolean;
  Band: TListOfPanel;
  zeiger, k: integer;
  temp, currentZ: integer;
  hasErw: boolean;
  bandContent: TListOfString;
  leerzeichen: char;
  MaschineAl: TListofString;
  Zustand2: TListOfInt;
  currentWorkDir: string;
  delay: integer;

implementation

{$R *.lfm}

{ TForm1 }
{
 Vorbereitung für TM

}
procedure TForm1.FormCreate(Sender: TObject);
begin
  einstellungenLesenUndSetzen;
  finished := True;
  hasMoved := True;
  currentZ := 1;
  bandContent := TListOfString.Create;
  Band := TListOfPanel.Create;
  MaschineAl := TListOfString.Create;
  Self.DoubleBuffered := True;
  leerzeichen := '#';
  zeiger := 6;
  for i := 1 to 13 do
  begin
    Band.Add(TPanel(Form1.FindComponent('Panel' + i.toString)));
    Band.getItem(i - 1).DoubleBuffered := True;
    bandContent.Add(leerzeichen);
  end;
  Zustand2 := TListOFInt.Create;
  Zustand2.Add(1);
  setViewMode(0);
end;

{
 Setze Breite
}
procedure TForm1.FormShow(Sender: TObject);
begin
  breite := Panel7.Width;
end;

{
 Wenn sich der Programmname ändert, setze *
}
procedure TForm1.LabeledEdit2EditingDone(Sender: TObject);
begin
  if Length(Form1.Caption) > Length('Turingmaschine') then
  begin
    tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
    tmInhalt.IniSection := 'info';
    if not string(LabeledEdit2.Text).Equals(tmInhalt.ReadString(
      'programmname', '')) then
    begin
      Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
      ToolButton13.Enabled := True;
    end;
  end;
end;

{
  Wenn sich der Autor ändert, setze *
}
procedure TForm1.LabeledEdit3EditingDone(Sender: TObject);
begin
  if Length(Form1.Caption) > Length('Turingmaschine') then
  begin
    tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
    tmInhalt.IniSection := 'info';
    if not string(LabeledEdit3.Text).Equals(tmInhalt.ReadString('autor', '')) then
    begin
      Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
      ToolButton13.Enabled := True;
    end;
  end;
end;

{
  Wenn sich der Kurzbeschreibung ändert, setze *
}
procedure TForm1.LabeledEdit4EditingDone(Sender: TObject);
begin
  if Length(Form1.Caption) > Length('Turingmaschine') then
  begin
    tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
    tmInhalt.IniSection := 'info';
    if not string(LabeledEdit4.Text).Equals(tmInhalt.ReadString(
      'kurzbeschreibung', '')) then
    begin
      Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
      ToolButton13.Enabled := True;
    end;
  end;
end;

{
 Setze Dateiname in Caption von Form1 und setze currentWorkDir
}
procedure TForm1.OpenDialog1Close(Sender: TObject);
begin
  if not OpenDialog1.FileName.Equals('') and OpenDialog1.FileName.EndsWith('.tm') then
  begin
    Form1.Caption := 'Turingmaschine - ' + ExtractFileName(OpenDialog1.FileName);
    CurrentWorkDir := OpenDialog1.FileName;
  end;
end;

{
 Speichere Daten bei Tabwechsel
}
procedure TForm1.PageControl1Change(Sender: TObject);
begin
  StringGrid1.AutoFillColumns := CheckGroup1.Checked[0];
  animation := CheckGroup2.Checked[0];
  settings.IniSection := 'settings';
  settings.WriteBoolean('DoAutoSizeCols', CheckGroup1.Checked[0]);
  settings.WriteBoolean('DoAnimation', CheckGroup2.Checked[0]);
  settings.WriteInteger('Delay', SpinEdit1.Value);
  settings.WriteInteger('DoEveryMove', RadioGroup1.ItemIndex);
  //***
end;

{
 Setze Dateiname in Caption von Form1, und setze CurrentWorkDir
}
procedure TForm1.SaveDialog1Close(Sender: TObject);
begin
  if not SaveDialog1.FileName.Equals('') and SaveDialog1.FileName.EndsWith('.tm') then
  begin
    Form1.Caption := 'Turingmaschine - ' + ExtractFileName(SaveDialog1.FileName);
    CurrentWorkDir := SaveDialog1.FileName;
  end;
end;

{
 Setze Delay
}
procedure TForm1.SpinEdit1EditingDone(Sender: TObject);
begin
  Timer3.Interval := SpinEdit1.Value;
end;

{
 Öffne GitHub
}
procedure TForm1.StaticText1Click(Sender: TObject);
begin
  OpenURL('https://github.com/erikspall/turingMaschine');
end;

{
 leerzeichen setzen
}
procedure TForm1.Edit3EditingDone(Sender: TObject);
var
  changed2: boolean;
  prev: char;  //Letzes Leerzeichen
begin
  prev := leerzeichen;
  if not string(Edit3.Text).Contains(prev) then
    //Wenn das Leerzeichen nicht das selbe ist
  begin
    ToolButton5.Click;     //Zurücksetzen
    if not string(Edit1.Text).Contains(Edit3.Text) then
      //Wenn das leerzeichen nicht schon im Alphabet ist
    begin

  {
   * setzen
  }
      if Length(Form1.Caption) > Length('Turingmaschine') then
      begin
        tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
        tmInhalt.IniSection := 'edits';
        if not string(Edit3.Text).Equals(tmInhalt.ReadString('leerzeichen', '')) then
        begin
          Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
          ToolButton13.Enabled := True;
        end;
      end;

      Label3.Caption := '';  //Fehler anzeigen löschen
      if leerzeichen = Edit3.Text[1] then   //Wenn es das selbe ist
        changed2 := False
      else
        changed2 := True;

      leerzeichen := Edit3.Text[1]; //Setze neues Leerzeichen
      if changed2 then              //Wenn es das selbe ist
      begin
        for i := 0 to bandContent.Count - 1 do      //Durchlaufe content
        begin
          if bandContent.getItem(i) = prev then
            //Wenn es das alte Leerzeichen ist
            bandContent.replaceItem(i, leerzeichen);    //ersetzen
        end;
        initBand;                                     //Band iniziieren
      end;
      Form1.StringGrid1.Cells[1, 0] := leerzeichen;
      //Setze neues Leerzeichen in StringGrid
    end
    else
    begin
      Label3.Caption := 'Ungültige Eingabe';       //Fehler anzeigen
      Edit3.Text := prev;
    end;
  end;
end;

{
  Überprüfe auf ungeänderte Daten
}
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  h, g: integer; //random Zählvariablen
begin
  if string(Form1.Caption).Contains('*') then //Wenn ungeänderte Daten
  begin
    if Application.MessageBox('Geänderte Werte speichern?', 'Änderungen!',
      MB_ICONQUESTION + MB_YESNO) = idYes  //Frage ob es gespeichert werden soll
    then
    begin
    {
     Speicher...
    }
      tmInhalt.IniFileName := currentWorkDir;
      tmInhalt.IniSection := 'edits';
      tmInhalt.WriteString('eingabewort', Edit2.Text);
      tmInhalt.WriteString('leerzeichen', Edit3.Text);
      tmInhalt.WriteString('alphabet', Edit1.Text);
      tmInhalt.WriteInteger('zustände', StringGrid1.RowCount);
      tmInhalt.IniSection := 'grid';
      h := 1;
      for g := 1 to StringGrid1.RowCount - 1 do
      begin
        for i := 1 to StringGrid1.ColCount - 1 do
        begin
          tmInhalt.WriteString('I' + h.toString, StringGrid1.Cells[i, g]);
          Inc(h);
        end;
      end;
      tmInhalt.IniSection := 'info';
      tmInhalt.WriteString('programmname', LabeledEdit2.Text);
      tmInhalt.WriteString('autor', LabeledEdit3.Text);
      tmInhalt.WriteString('kurzbeschreibung', LabeledEdit4.Text);
    end;
  end;
end;

{
 Alphabet wurde eingetragen
}
procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  if not lastInputAl.Equals(AnsiUpperCase(Edit1.Text)) then
    //Wenn neues Alphabet nicht das gleiche wie altes
  begin
  {
   Setze *
  }
    if Length(Form1.Caption) > Length('Turingmaschine') then
    begin
      tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
      tmInhalt.IniSection := 'edits';
      if not string(Edit1.Text).Equals(tmInhalt.ReadString('alphabet', '')) then
      begin
        Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
        ToolButton13.Enabled := True;
      end;
    end;

    {
     Eigentliches Setzen des Alphabets
    }
    lastInputAl := AnsiUpperCase(Edit1.Text);
    Edit1.Text := lastInputAl;
    Label1.Caption := 'Alphabet: {';
    PrepareStringGrid;

    {
     Setze Anzeige
    }
    for i := 2 to StringGrid1.ColCount - 2 do
    begin
      Label1.Caption := Label1.Caption + StringGrid1.Cells[i, 0] + ',';
    end;
    Label1.Caption := Label1.Caption + StringGrid1.Cells[StringGrid1.ColCount -
      1, 0] + '}';
    setViewMode(1);
  end;
end;

{
 Eingabewort setzen und aufs Band bringen
}
procedure TForm1.Edit2EditingDone(Sender: TObject);
begin
  if not lastInputEin.Equals(AnsiUpperCase(Edit2.Text)) then
    //Wenn es nicht das gleiche wie vorher ist
  begin
  {
   Setze *
  }
    if Length(Form1.Caption) > Length('Turingmaschine') then
    begin
      tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
      tmInhalt.IniSection := 'edits';
      if not string(Edit2.Text).Equals(tmInhalt.ReadString('eingabewort', '')) then
      begin
        Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
        ToolButton13.Enabled := True;
      end;
    end;

    {
     Setze Eingabewort
    }
    lastInputEin := AnsiUpperCase(Edit2.Text);
    Edit2.Text := lastInputEin;
    ToolButton5.Click;
    setViewMode(4);
  end;
end;

{
 Eingabe für eine Zelle starten
}
procedure TForm1.StringGrid1DblClick(Sender: TObject);
var
  wohin: char;
begin
  if not ((StringGrid1.Col = 0) or (StringGrid1.Row = 0)) then
    //Wenn es im richtigen Bereich ist
  begin
    if Form2.Execute then    //Öffne den Dialog
    begin
    {
     Setze Infos
    }
      if Form2.EndZustand then
      begin
        StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := '~Ende~';
      end
      else
      begin
        case Form2.WhereToGo of
          -1: Wohin := 'L';
          0: Wohin := '0';
          1: Wohin := 'R';
        end;
         {
          Setze *
         }
        if Length(Form1.Caption) > Length('Turingmaschine') then
        begin
          if not StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row].Equals(
            Wohin + ';' + Form2.WhatToWrite + ';Z' + Form2.Zustand.toString) then
          begin
            Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
            ToolButton13.Enabled := True;
          end;
        end;
        {
         Setze Eingabewort
        }
        StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] :=
          Wohin + ';' + Form2.WhatToWrite + ';Z' + Form2.Zustand.toString;
      end;
    end;
  end;
end;

{
 Einstellungen...
}
procedure TForm1.einstellungenLesenUndSetzen();
begin
  settings.iniSection := 'settings';
  CheckGroup1.Checked[0] := settings.ReadBoolean('DoAutoSizeCols', True);
  CheckGroup2.Checked[0] := settings.ReadBoolean('DoAnimation', True);
  SpinEdit1.Value := settings.ReadInteger('Delay', 100);
  Timer3.Interval := SpinEdit1.Value;
  RadioGroup1.ItemIndex := settings.ReadInteger('DoEveryMove', 0);
end;

{
 Vorwärtsbewegung
}
procedure TForm1.moveForward();
begin
  if hasMoved then //hasMoved ist Wahr wenn die Animation fertig ist
  begin
    hasMoved := False;
    Inc(Schritte);
    StatusBar1.Panels.Items[0].Text := 'Schritte: ' + Schritte.toString;
    temp := band.getItem(0).Left;
    Form1.Timer1.Enabled := True;
  end
  else
  begin
  end;
end;

{
 Das Band fertigstellen
}
procedure TForm1.initBand();
begin
  for i := 0 to band.Count() - 1 do   //Durchlaufe Panel
  begin
    if i >= zeiger then              //Sobald Content verfügbar
      Band.getItem(i).Caption := bandContent.getItem(i)
    else
      Band.getItem(i).Caption := leerzeichen;
  end;
end;

{
 Band vorbereiten
}
procedure TForm1.prepareBand();
var
  t: string;        //Temporäre Vergleichsvariable
  j: integer;       //random Zähler
  isInvalid: boolean = False;
begin
  t := Edit1.Text;
  isInvalid := False;

  {
   Checke ob Eingabe gültig ist
  }
  for i := 1 to Length(Edit2.Text) do
  begin
    if t.Contains(Edit2.Text[i]) or (Edit2.Text[i] = leerzeichen) then
    begin
      Label2.Caption := '';

    end
    else
    begin
      Label2.Caption := 'Ungültige Eingabe';
      Edit2.Clear;
      isInvalid := True;
      break;
    end;
  end;

  {
   BandContent aufs Band bringen
  }
  if not isInvalid then
  begin
    for j := 0 to Length(Edit2.Text) - 1 do  //Eingabe durchlaufen
    begin
      if j + zeiger - 1 < bandContent.Count - 1 then
        //Wenn COntent vorhanden dann ersetze
      begin
        bandContent.replaceItem(j + 6, Edit2.Text[j + 1]);
      end
      else
      begin
        bandContent.add(Edit2.Text[j + 1]);         //Sonst füge hinzu
      end;
    end;
    initBand();
  end;
end;

{
 Rückwärts bewegen
}
procedure TForm1.moveBackward();
begin
  if hasMoved then   //Wenn  bewegt worden
  begin
    Inc(Schritte);
    StatusBar1.Panels.Items[0].Text := 'Schritte: ' + Schritte.tOString;
    hasMoved := False;
    temp := Band.getItem(0).Left;
    hasErw := False;
    Form1.Timer2.Enabled := True;
  end;
end;

{
 Den nächsten Schritt durchführen
}
procedure TForm1.handleMove();
var
  Read: char;
  X, Y: integer;
  writeS: string;
  GridRect: TGridRect;
begin
  Read := bandContent.getItem(zeiger)[1];  //Gelesenes Zeichen

  {
   Finde die Richtige Zelle
  }
  for i := 1 to StringGrid1.ColCount - 1 do
  begin
    if StringGrid1.Cells[i, 0] = Read then
    begin
      X := i;
      break;
    end;
  end;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if StrToInt(StringGrid1.Cells[0, i].SubString(1)) = currentZ then
    begin
      Y := i;
      break;
    end;
  end;

  {
   Setze Selection Grid
  }
  with GridRect do
  begin
    Top := Y;
    Left := X;
    Right := X;
    Bottom := Y;
  end;

  {
   Wenn keine Anweisung vorhanden: Abbrechen
  }
  if StringGrid1.Cells[X, Y] = '' then
  begin
    finished := True;
    ToolButton1.Down := False;
    Timer3.Enabled := False;
    setViewMode(3);
    Application.MessageBox(PChar('Keine Anweisung Vorhanden für: Column: ' +
      X.toString + ' Zustand: ' + Y.toString + sLineBreak + sLineBreak +
      'Breche ab ...'), PChar('Fehler!'), MB_ICONERROR + MB_OK);

  end
  else
  begin
    StringGrid1.Selection := GridRect; //Selecte

  {
   Entscheide ob nach Links / Rechts oder gar nicht
  }
    if StringGrid1.Cells[X, Y] <> '~Ende~' then
    begin
      if StringGrid1.Cells[X, Y].Chars[0] = 'L' then
        moveBackward()
      else
      if StringGrid1.Cells[X, Y].Chars[0] = 'R' then
        moveForward()
      else if StringGrid1.Cells[X, Y].Chars[0] = '0' then
      begin
        if finished then
          setViewMode(3);
      end;

    {
     Setze Zeug
    }
      writeS := StringGrid1.Cells[X, Y].Chars[2];
      currentZ := StringGrid1.Cells[X, Y].Substring(5).ToInt64;
      StatusBar1.Panels.items[1].Text := 'Zustand: ' + currentZ.toString;
      bandContent.replaceItem(zeiger, writeS);
      band.getItem(6).Caption := writeS;
    end
    else
    begin
  {
   Wenn fertig
  }
      finished := True;
      ToolButton1.Down := False;
      Timer3.Enabled := False;
      setViewMode(3);
      ShowMessage('Ende');
    end;
  end;
end;

{
 TM Laden
}
function TForm1.loadTM(FileName: string): boolean;
var
  g, h: integer;
begin
  try
    Zustand2.Clear;
    Zustand2.Add(1);
    tmInhalt.IniFileName := OpenDialog1.FileName;
    tmInhalt.IniSection := 'edits';
    Edit1.Text := tmInhalt.ReadString('alphabet', '');
    Edit1.EditingDone;
    Edit2.Text := tmInhalt.ReadString('eingabewort', '');
    edit2.EditingDone;
    Edit3.Text := tmInhalt.ReadString('leerzeichen', '#');
    edit3.EditingDone;

    for g := tmInhalt.ReadInteger('zustände', 2) - 1 downto 2 do
    begin
      ToolButton3.Click;
    end;
    tmInhalt.IniSection := 'grid';
    h := 1;
    for g := 1 to StringGrid1.RowCount - 1 do
    begin
      for i := 1 to StringGrid1.ColCount - 1 do
      begin
        StringGrid1.Cells[i, g] := tmInhalt.ReadString('I' + h.toString, '');
        Inc(h);
      end;
    end;
    tmInhalt.IniSection := 'info';
    LabeledEdit2.Text := tmInhalt.ReadString('programmname', '');
    LabeledEdit3.Text := tmInhalt.ReadString('autor', '');
    LabeledEdit4.Text := tmInhalt.ReadString('kurzbeschreibung', '');
    Form1.Caption := 'Turingmaschine - ' + ExtractFileName(OpenDialog1.FileName);
    Result := True;
  except
    Result := False;
  end;
end;

{
 Wenn Vorwärtsbewegung fertig (für Schrittweise wichtig)
}
procedure TForm1.Timer1StopTimer(Sender: TObject);
begin
  if finished then
    setViewMode(3);
end;

{
 TM Zurücksetzen
}
procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  StringGrid1.ClearSelections;
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  Timer3.Enabled := False;
  finished := True;
  hasMoved := True;
  currentZ := 1;
  StatusBar1.Panels.items[1].Text := 'Zustand: ' + currentZ.toString;
  Schritte := 0;
  StatusBar1.Panels.Items[0].Text := 'Schritte: ' + Schritte.toString;
  bandContent.Clear;
  band.Clear;
  MaschineAl.Clear;
  Self.DoubleBuffered := True;
  if Edit3.Text <> '' then
  begin
    leerzeichen := Edit3.Text[1];
  end
  else
  begin
    leerzeichen := '#';
  end;
  zeiger := 6;
  for i := 1 to 13 do
  begin
    Band.Add(TPanel(Form1.FindComponent('Panel' + (i).ToString)));
    Band.getitem(i - 1).DoubleBuffered := True;
    Band.getItem(i - 1).Left := (i - 2) * breite;
    bandContent.add(leerzeichen);
  end;
  Edit1.Text := AnsiUpperCase(edit1.Text);
  prepareBand();
  setViewMode(4);
end;

{
 Bewegung Vorwärts
}
procedure TForm1.Timer1Timer(Sender: TObject);
var
  tempP: TPanel;
begin
  if animation then
  begin
    for i := 0 to band.Count - 1 do  //Bewege alle eins rüber
    begin
      Band.getItem(i).Left := Band.getItem(i).Left - 1;
    end;
    case RadioGroup1.ItemIndex of
      1: Refresh;
      2: Repaint;
      3: Update;
    end;
  end
  else
  begin
    for i := 0 to band.Count - 1 do
    begin
      Band.getItem(i).Left := Band.getItem(i).Left - breite;
    end;
  end;

  if Band.getItem(0).Left = temp - breite then //Wenn animation fertig
  begin
    if bandContent.Count - 1 >= (zeiger + 7) then   //Setze Content
    begin
      band.getItem(0).Caption := bandContent.getItem(zeiger + 7);
    end
    else
    begin
      band.getItem(0).Caption := leerzeichen;
      bandContent.add(leerzeichen);
    end;

    hasMoved := True;
    timer1.Enabled := False;
    Inc(zeiger);
    tempP := Band.getItem(0);
    Band.getItem(0).Left := Band.getItem(0).Left + breite * 13;
    for i := 0 to band.Count - 2 do
    begin
      band.replaceItem(i, Band.getItem(i + 1));
    end;
    Band.replaceItem(band.Count - 1, tempP);
  end;

end;

{
 Wenn Rückwärts
}
procedure TForm1.Timer2StopTimer(Sender: TObject);
begin
  if finished then
    setViewMode(3);
end;

{
 Rückwärtsbewegen
}
procedure TForm1.Timer2Timer(Sender: TObject);
var
  tempP: TPanel;
begin
  if not hasErw then
  begin
    hasErw := True;
    tempP := Band.getItem(Band.Count - 1);
    if zeiger - 7 >= 0 then
    begin
      band.getItem(band.Count - 1).Caption := bandContent.getItem(zeiger - 7);
    end
    else
    begin
      band.getItem(band.Count - 1).Caption := leerzeichen;
      bandContent.insertItem(leerzeichen, 0);
      Inc(Zeiger);
    end;
    Band.getItem(band.Count - 1).Left := Band.getItem(band.Count - 1).Left - breite * 13;
    for i := band.Count - 1 downto 1 do
    begin
      band.replaceItem(i, band.getItem(i - 1));
    end;
    Band.replaceItem(0, tempP);
  end;
  if animation then
  begin
    for i := 0 to band.Count - 1 do
    begin
      Band.getItem(i).Left := Band.getItem(i).Left + 1;
    end;
  end
  else
  begin
    for i := 0 to band.Count - 1 do
    begin
      Band.getItem(i).Left := Band.getItem(i).Left + breite;
    end;
    case RadioGroup1.ItemIndex of
      1: Refresh;
      2: Repaint;
      3: Update;
    end;
  end;
  if Band.getItem(1).Left = temp + breite then
  begin
    timer2.Enabled := False;
    hasMoved := True;
    Dec(Zeiger);
  end;
end;

{
 Wenn handler startet
}
procedure TForm1.Timer3StartTimer(Sender: TObject);
begin
  setViewMode(2);
  handleMove();
  if finished then
    Timer3.Enabled := False;
end;


{
 Wenn Stop
}
procedure TForm1.Timer3StopTimer(Sender: TObject);
begin
  setViewMode(3);
end;

{
 Der MoveHandler caller
}
procedure TForm1.Timer3Timer(Sender: TObject);
begin
  if (not finished) and (hasMoved) then
  begin
    handleMove();
    if finished then
      Timer3.Enabled := False;
  end;
end;

{
 Bewege Band nach vorn
}
procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  setViewMode(2);
  moveForward();
end;

{
 Step
}
procedure TForm1.ToolButton11Click(Sender: TObject);
begin
  setViewMode(2);
  handleMove();
end;

{
 Neues Programm
}
procedure TForm1.ToolButton12Click(Sender: TObject);
begin
  if idYes = Application.MessageBox('Möchten sie ein neues Programm erstellen?',
    'Achtung', MB_YESNO + MB_ICONQUESTION) then
  begin
    Zustand2.Clear;
    Zustand2.Add(1);
    Form1.Caption := 'Turingmaschine';
    Label1.Caption := 'Alphabet: {}';
    currentWorkDir := '';
    Label2.Caption := '';
    Label3.Caption := '';
    Edit1.Clear;
    Edit2.Clear;
    LabeledEdit2.Clear;
    LabeledEdit3.Clear;
    LabeledEdit4.Clear;
    ToolButton5.Click;
    lastInputAl := '';
    lastInputEin := '';
    setViewMode(0);
    StringGrid1.ColCount := 2;
    StringGRID1.RowCount := 2;
    StringGRID1.Cells[1, 1] := '';
  end;
end;

{
 Speichern
}
procedure TForm1.ToolButton13Click(Sender: TObject);
var
  h, g: integer;
begin
  ToolButton13.Enabled := False;
  Form1.Caption := 'Turingmaschine - ' + extractfilename(currentWorkDir);
  tmInhalt.IniFileName := currentWorkDir;
  tmInhalt.IniSection := 'edits';
  tmInhalt.WriteString('eingabewort', Edit2.Text);
  tmInhalt.WriteString('leerzeichen', Edit3.Text);
  tmInhalt.WriteString('alphabet', Edit1.Text);
  tmInhalt.WriteInteger('zustände', StringGrid1.RowCount);
  tmInhalt.IniSection := 'grid';
  h := 1;
  for g := 1 to StringGrid1.RowCount - 1 do
  begin
    for i := 1 to StringGrid1.ColCount - 1 do
    begin
      tmInhalt.WriteString('I' + h.toString, StringGrid1.Cells[i, g]);
      Inc(h);
    end;
  end;
  tmInhalt.IniSection := 'info';
  tmInhalt.WriteString('programmname', LabeledEdit2.Text);
  tmInhalt.WriteString('autor', LabeledEdit3.Text);
  tmInhalt.WriteString('kurzbeschreibung', LabeledEdit4.Text);
end;

{
 Starte TM
}
procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if finished then
    finished := False;
  schritte := 0;
  setViewMode(2);
  Timer3.Enabled := True;
end;

{
 Zustand hinzufügen
}
procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  if Length(Form1.Caption) > Length('Turingmaschine') then
  begin
    tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
    tmInhalt.IniSection := 'edits';
    if Zustand2.Count <> tmInhalt.ReadInteger('zustände', 1) then
    begin
      Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
      ToolButton13.Enabled := True;
    end;
  end;

  Zustand2.add(Zustand2.Count + 1);
  with StringGrid1 do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount - 1] := 'Z' + Zustand2.getItem(Zustand2.Count - 1).toString;
  end;
end;

{
 Zustand entfernen
}
procedure TForm1.ToolButton4Click(Sender: TObject);
var
  reply: boolean = True;
begin
  for i := 2 to StringGrid1.ColCount - 1 do
  begin
    if not StringGrid1.Cells[i, StringGrid1.RowCount - 1].Equals('') then
    begin
      if idYes = Application.MessageBox('Zustand entfernen?',
        'Achtung', MB_YESNO + MB_ICONQUESTION) then
        reply := True
      else
        reply := False;
    end;
  end;
  if reply then
  begin
    if Length(Form1.Caption) > Length('Turingmaschine') then
    begin
      tmInhalt.IniFileName := ExtractFileName(currentWorkDir);
      tmInhalt.IniSection := 'edits';
      if Zustand2.Count <> tmInhalt.ReadInteger('zustände', 1) then
      begin
        Form1.Caption := 'Turingmaschine - ' + '*' + extractFileName(currentWorkDir);
        ToolButton13.Enabled := True;
      end;
      // else Form1.Caption:='Turingmaschine - '  + extractFileName(currentWorkDir);
    end;

    if StringGrid1.RowCount > 2 then
    begin
      Zustand2.deleteItemAt(Zustand2.Count - 1);
      with StringGrid1 do
        RowCount := RowCount - 1;
    end;
  end;
end;

{
 Disable / Enable
}
procedure TForm1.setViewMode(mode: integer);
begin
  case mode of
    0:
    begin //Nach Start, wenn nichts eingetragen
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := False;
      GroupBox3.Enabled := False;
      StringGrid1.Enabled := False;
      Toolbutton1.Enabled := False;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := False;
      Toolbutton4.Enabled := False;
      Toolbutton5.Enabled := False;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := False;
      Toolbutton8.Enabled := True;
      ToolButton9.Enabled := False;
      ToolButton10.Enabled := False;
      ToolButton11.Enabled := False;
      ToolButton12.Enabled := False;
      CheckGroup1.Enabled := True;
      CheckGroup2.Enabled := True;
    end;
    1:
    begin     //Das Alphabet wurde eingegeben
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := True;
      GroupBox3.Enabled := True;
      StringGrid1.Enabled := True;
      Toolbutton1.Enabled := False;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := True;
      Toolbutton4.Enabled := True;
      Toolbutton5.Enabled := False;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := True;
      Toolbutton8.Enabled := True;
      ToolButton9.Enabled := False;
      ToolButton10.Enabled := False;
      ToolButton11.Enabled := False;
      ToolButton12.Enabled := True;
      CheckGroup1.Enabled := True;
      CheckGroup2.Enabled := True;
    end;
    2:
    begin //tm läuft aktuell
      GroupBox1.Enabled := False;
      GroupBox2.Enabled := False;
      GroupBox3.Enabled := False;
      StringGrid1.Enabled := False;
      Toolbutton1.Enabled := False;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := False;
      Toolbutton4.Enabled := False;
      Toolbutton5.Enabled := True;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := False;
      Toolbutton8.Enabled := False;
      ToolButton9.Enabled := False;
      ToolButton10.Enabled := False;
      ToolButton11.Enabled := False;
      ToolButton12.Enabled := False;
      CheckGroup1.Enabled := False;
      CheckGroup2.Enabled := False;
    end;
    3:
    begin //tm ist fertig
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := True;
      GroupBox3.Enabled := True;
      StringGrid1.Enabled := True;
      Toolbutton1.Enabled := True;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := True;
      Toolbutton4.Enabled := True;
      Toolbutton5.Enabled := True;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := True;
      Toolbutton8.Enabled := True;
      ToolButton9.Enabled := True;
      ToolButton10.Enabled := True;
      ToolButton11.Enabled := True;
      ToolButton12.Enabled := True;
      CheckGroup1.Enabled := True;
      CheckGroup2.Enabled := True;
    end;
    4:
    begin //wurde resettet / startbereit
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := True;
      GroupBox3.Enabled := True;
      StringGrid1.Enabled := True;
      Toolbutton1.Enabled := True;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := True;
      Toolbutton4.Enabled := True;
      Toolbutton5.Enabled := False;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := True;
      Toolbutton8.Enabled := True;
      ToolButton9.Enabled := True;
      ToolButton10.Enabled := True;
      ToolButton11.Enabled := True;
      ToolButton12.Enabled := True;
      CheckGroup1.Enabled := True;
      CheckGroup2.Enabled := True;
    end;
    5:
    begin     //Das Eingabewort wurde eingegeben
      GroupBox1.Enabled := True;
      GroupBox2.Enabled := True;
      GroupBox3.Enabled := True;
      StringGrid1.Enabled := True;
      Toolbutton1.Enabled := True;
      Toolbutton2.Enabled := True;
      Toolbutton3.Enabled := True;
      Toolbutton4.Enabled := True;
      Toolbutton5.Enabled := False;
      Toolbutton6.Enabled := True;
      Toolbutton7.Enabled := True;
      Toolbutton8.Enabled := True;
      ToolButton9.Enabled := False;
      ToolButton10.Enabled := False;
      ToolButton11.Enabled := True;
      ToolButton12.Enabled := True;
      CheckGroup1.Enabled := True;
      CheckGroup2.Enabled := True;
    end;
  end;
end;

{
 Save as
}
procedure TForm1.ToolButton7Click(Sender: TObject);
var
  g, h: integer;
begin
  if SaveDialog1.Execute then
  begin
    tmInhalt.IniFileName := SaveDialog1.FileName;
    tmInhalt.IniSection := 'edits';
    tmInhalt.WriteString('eingabewort', Edit2.Text);
    tmInhalt.WriteString('leerzeichen', Edit3.Text);
    tmInhalt.WriteString('alphabet', Edit1.Text);
    tmInhalt.WriteInteger('zustände', StringGrid1.RowCount);
    tmInhalt.IniSection := 'grid';
    h := 1;
    for g := 1 to StringGrid1.RowCount - 1 do
    begin
      for i := 1 to StringGrid1.ColCount - 1 do
      begin
        tmInhalt.WriteString('I' + h.toString, StringGrid1.Cells[i, g]);
        Inc(h);
      end;
    end;
    tmInhalt.IniSection := 'info';
    tmInhalt.WriteString('programmname', LabeledEdit2.Text);
    tmInhalt.WriteString('autor', LabeledEdit3.Text);
    tmInhalt.WriteString('kurzbeschreibung', LabeledEdit4.Text);
  end;
end;

{
 Lade TM
}
procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    loadTM(OpenDialog1.FileName);
  end;
end;

{
  Band zurück
}
procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  setViewMode(2);
  moveBackward();
end;

{
 StringGrid vorbereiten (Einträge etc.)
}
procedure TForm1.prepareStringGrid();
var
  rawA: string;
  j, l: integer;
  doneDeleting: boolean;
begin
  rawA := Edit1.Text;

  repeat
    doneDeleting := False;
    for i := 1 to Length(rawA) do
    begin
      if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ+-/0123456789'.Contains(rawA[i]) or
        (rawA[i] = leerzeichen) then
      begin
        Delete(rawA, i, 1);
      end;
    end;
    if (i > Length(rawA)) and (Length(rawA) <> 0) then
      doneDeleting := False
    else
      doneDeleting := True;
  until doneDeleting;

  if Length(rawA) <> 0 then
  begin
    StringGrid1.Cells[1, 0] := leerzeichen;
    for i := 2 to StringGrid1.ColCount - 1 do
    begin
      if i >= StringGrid1.ColCount then
        break;
      while not rawA.Contains(StringGrid1.Cells[i, 0]) and
        (StringGrid1.ColCount > 2) do
      begin
        if i + 1 < StringGrid1.ColCount then
        begin
          for l := i to StringGrid1.ColCount - 2 do
          begin
            for j := 0 to StringGrid1.RowCount - 1 do
            begin
              StringGrid1.Cells[l, j] := StringGrid1.Cells[l + 1, j];
            end;
          end;
        end;
        StringGrid1.ColCount := StringGrid1.ColCount - 1;
        if i >= StringGrid1.ColCount then
          break;
      end;
    end;
    //Lösche alle bereits vorhandenen aus rawA
    for i := 2 to StringGrid1.ColCount - 1 do
    begin
      if rawA.Contains(StringGrid1.Cells[i, 0]) then
      begin
        rawA := rawA.Remove(rawA.IndexOf(StringGrid1.Cells[i, 0]), 1);
      end;
    end;
    //Füge alle benötigten hinzu
    for i := 1 to Length(rawA) do
    begin
      if not StringGrid1.Rows[0].Text.Contains(rawA[i]) then
      begin

      StringGrid1.ColCount := StringGrid1.ColCount + 1;
      StringGrid1.Cells[StringGrid1.ColCount - 1, 0] := rawA[i];
      end;

    end;
    Edit2.Clear;
    Edit2.EditingDone;
    StringGrid1.RowCount := Zustand2.Count + 1;
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[0, i] := 'Z' + Zustand2.getItem(i - 1).toString;
    end;
  end;
end;

end.
