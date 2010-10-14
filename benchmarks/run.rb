#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/src/helper'
require File.dirname(__FILE__) + '/src/complex_view'

require 'ostruct'
require 'erb'
require 'haml'
require 'slim'

tpl_erb  = File.read(File.dirname(__FILE__) + '/src/complex.erb')
tpl_haml = File.read(File.dirname(__FILE__) + '/src/complex.haml')
tpl_slim = File.read(File.dirname(__FILE__) + '/src/complex.slim')

view  = ComplexView.new
eview = OpenStruct.new(:header => view.header, :item => view.item).instance_eval{ binding }

erb  = ERB.new(tpl_erb)
haml = Haml::Engine.new(tpl_haml)
slim = Slim::Engine.new(tpl_slim)

bench('erb')           { ERB.new(tpl_erb).result(eview) }
bench('slim')          { Slim::Engine.new(tpl_slim).render(view) }
bench('haml')          { Haml::Engine.new(tpl_haml).render(view) }
bench('erb (cached)')  { erb.result(eview) }
bench('slim (cached)') { slim.render(view) }
bench('haml (cached)') { haml.render(view) }