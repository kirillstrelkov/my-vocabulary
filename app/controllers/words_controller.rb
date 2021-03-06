# frozen_string_literal: true

class WordsController < ApplicationController
  helper DictionaryHelper
  include CardGeneratorHelper
  before_action :set_word, only: %i[show edit update destroy]

  # GET /words
  # GET /words.json
  def index
    @words = current_user ? current_user.words.with_lang_pair(@lang_pair).page(params[:page]) : []
  end

  # GET /words/1
  # GET /words/1.json
  def show; end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit; end

  # GET /words/play
  def play
    if Rails.env.production?
      @cards = user_signed_in? ? generate_cards(current_user) : nil
    else
      rng = params[:seed] ? Random.new(params[:seed].to_i) : nil
      text1 = params[:text1]
      @cards = user_signed_in? ? generate_cards(current_user, rng, text1) : nil
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

  def set_word
    @word = Word.find(params[:id])
    set_lang_pair
  end

  def word_params
    params[:word][:user_id] = current_user.id
    params.require(:word).permit(
      :lang_code1, :lang_code2,
      :text1, :text1_gender,
      :text2, :text2_gender,
      :pos,
      :user_id
    )
  end
end
