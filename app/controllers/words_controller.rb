class WordsController < ApplicationController
  helper DictionaryHelper
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :set_lang_pair, only: [:index, :new]

  # GET /words
  # GET /words.json
  def index
    @words = Word.all
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # GET /words/play
  def play
    if Word.count > 4
      word = Word.all.sample
      translations = Word.where(
          lang_code1: word.lang_code1,
          lang_code2: word.lang_code2
      ).where.not(text1: word.text1, text2: word.text2).limit(3) + [word]
      translations.shuffle!
      @cards = {
          word: word,
          translations:  translations
      }
    else
      @cards = nil
    end
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
      set_lang_pair
    end

    def set_lang_pair
      if @word
        @lang_pair = [@word.lang_code1, @word.lang_code2]
      else
        @lang_pair = [I18n.locale, nil]
      end
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:lang_code1, :lang_code2, :text1, :text2, :pos)
    end
end
