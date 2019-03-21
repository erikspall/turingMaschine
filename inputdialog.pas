unit inputDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;

  private

  public
     var
     WhatToWrite:Char;
     WhereToGo:Integer;
     resu:Boolean;
     zustand:Integer;
     endZustand:Boolean;
     function Execute:Boolean;
     procedure jaMoin;
  end;

var
  Form2: TForm2;

implementation
  uses mainForm;
{$R *.lfm}

  { TForm2 }

function TForm2.Execute: Boolean;
begin
    ComboBox1.Clear;
    ComboBox2.Clear;
    if Form1.StringGrid1.Cells[Form1.StringGrid1.Col,Form1.StringGrid1.Row] = '~Ende~' then
    begin
      endZustand:=true;
      CheckBox1.Checked := true;
    end
    else
    begin
      endZustand:=false;
      CheckBox1.Checked:=false;
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
    RadioButton2.Checked:=true;
    result:=(ShowModal = mrOk);
    EndZustand:=CheckBox1.Checked;

    Zustand:=StrToInt(ComboBox2.Items[ComboBox2.ItemIndex][2]);
    WhatToWrite:=ComboBox1.Items[ComboBox1.ItemIndex][1];
    if RadioButton1.Checked then wheretogo:=-1;
    if RadioButton2.Checked then wheretogo:=0;
    if radiobutton3.checked then wheretogo:=1;
end;

procedure TForm2.jaMoin;
begin
    resu:=(ShowModal = mrOk);
    ComboBox1.Items.Clear;
    for i:=2 to Form1.StringGrid1.ColCount-1 do
    begin
      ComboBox1.ItemIndex:=0;
      WhatToWrite:=ComboBox1.Seltext[1];
      if RadioButton1.Checked then WhereToGo:=-1;
      if RadioButton2.Checked then WhereToGo:=0;
      if RadioButton3.Checked then WhereToGo:=1;
    end;
end;
end.

