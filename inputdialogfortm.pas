unit inputDialogforTM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    CheckBoxThemed1: TCheckBoxThemed;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;


    procedure CheckBoxThemed1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

  public
     var WhatToWrite:Char;
    WhereToGo:Integer;
    resu:Boolean;
    Zustand:Integer;
    EndZustand:Boolean;
    function Execute:Boolean;
    procedure jaMoin;
  end;

var
  Form2: TForm2;

implementation

uses mainTM;

{$R *.lfm}

{ TForm2 }

function TForm2.Execute: Boolean;
Var i:Integer;
begin
  ComboBox1.Items.Clear;
  ComboBox2.Items.Clear;
  if Form1.StringGrid1.Cells[Form1.StringGrid1.Col,Form1.StringGrid1.Row] = '~Ende~' then
  begin
    Endzustand:=true;
    CheckBoxThemed1.Checked:=true;
  end
  else
  begin
    Endzustand:=false;
    CheckBoxThemed1.Checked:=false;
  end;
  for i:=1 to Form1.StringGrid1.ColCount-1 do
  begin
     ComboBox1.Items.Add(Form1.StringGrid1.Cells[i,0]);
  end;
  for i:=1 to Form1.StringGrid1.RowCount-1 do
  begin
     ComboBox2.Items.Add(Form1.StringGrid1.Cells[0,i]);
  end;
  ComboBox1.ItemIndex:=Form1.StringGrid1.Col-1;
  ComboBox2.ItemIndex:=Form1.StringGrid1.Row-1;
  with Form1.StringGrid1 do
  begin
    if not Cells[Col,Row].Equals('') and not Cells[Col,Row].Equals('~Ende~') then
    begin

    if Cells[Col, Row].Chars[0] = 'L' then
       RadioButton1.Checked:=true
    else
    if Cells[col, row].Chars[0] = 'R' then
      RadioButton3.Checked:=true
    else if Cells[Col,row].Chars[0] = '0' then
    begin
      RadioButton2.Checked:=true;
    end
    else  RadioButton2.Checked:=true;

    ComboBox1.Caption := Cells[Col, row].Chars[2];
    ComboBox2.Caption := Cells[Col, row].Substring(4,2);
    end
    else RadioButton2.Checked:=true;





  //ComboBox1.SelText:=ComboBox1.Items.Text[Form1.Strin];
  //RadioButton2.Checked:=true;
  Result := (ShowModal = mrOk);
  EndZustand:=CheckBoxThemed1.Checked;
  if not EndZustand then
  begin
  Zustand:=StrToInt(ComboBox2.Items[ComboBox2.ItemIndex][2]);
  WhatToWrite:=ComboBox1.Items[ComboBox1.ItemIndex][1];
  if RadioButton1.Checked then wheretogo:=-1;
  if RadioButton2.checked then wheretogo:=0;
  if RadioButton3.checked then wheretoGo:=1;

  end;

end;

end;

procedure TForm2.FormShow(Sender: TObject);
begin

end;

procedure TForm2.CheckBoxThemed1Change(Sender: TObject);
begin
  with CheckboxThemed1 do
  begin
       if Checked then
       begin
       GroupBox1.Enabled:=false;
       GroupBox2.Enabled:=false;
       end
       else
       begin
        GroupBox1.Enabled:=true;
       GroupBox2.Enabled:=true;
       end;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm2.jaMoin;
begin
   resu := (ShowModal = mrOk);
  ComboBox1.Items.Clear;
  for i:=1 to Form1.StringGrid1.ColCount-1 do
  begin
     ComboBox1.Items.Add(Form1.StringGrid1.Cells[i,0]);
  end;
  ComboBox1.ItemIndex:=0;
  WhatToWrite:=ComboBox1.SelText[1];
  if RadioButton1.Checked then wheretogo:=-1;
  if RadioButton2.checked then wheretogo:=0;
  if RadioButton3.checked then wheretoGo:=1;
end;

end.

